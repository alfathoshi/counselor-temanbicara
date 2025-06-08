import 'dart:async';

import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../../../config/config.dart';

class ConsultationDetailController extends GetxController {
  final box = GetStorage();
  final arg = Get.arguments;

  final TextEditingController probController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController sumController = TextEditingController();

  late DateTime consultationStartTime;
  final canEdit = false.obs;
  Timer? _timer;

  String get formattedTime {
    final schedule = arg['schedule'];
    final startTime = DateFormat('HH:mm:ss').parse(schedule['start_time']);
    final endTime = DateFormat('HH:mm:ss').parse(schedule['end_time']);
    return '${DateFormat('HH:mm').format(startTime)} - ${DateFormat('HH:mm').format(endTime)}';
  }

  int calculateAge(String birthDate) {
    DateTime birthDateTime = DateFormat("yyyy-MM-dd").parse(birthDate);
    DateTime today = DateTime.now();

    int age = today.year - birthDateTime.year;

    if (today.month < birthDateTime.month ||
        (today.month == birthDateTime.month && today.day < birthDateTime.day)) {
      age--;
    }

    return age;
  }

  Future<void> updateReport() async {
    if (!canEdit.value) {
      CustomSnackbar.showSnackbar(
        title: 'Failed',
        message: 'Session has not started',
        status: false,
      );
      return;
    }
    final consultationId = box.read('consultation_id');
    final token = box.read('token');
    final response = await http.put(
      Uri.parse('${Config.apiEndPoint}/consultation/$consultationId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "description": descController.text,
        "problem": probController.text,
        "summary": sumController.text,
        "status": "Done"
      }),
    );
    if (response.statusCode == 200) {
      CustomSnackbar.showSnackbar(
        title: 'Report sent',
        message: 'Your report has sent',
        status: true,
      );
      return json.decode(response.body);
    } else {
      CustomSnackbar.showSnackbar(
        title: 'Report error',
        message: 'Your report has not sent',
        status: false,
      );
    }
  }

  void _checkSessionStatus() {
    final now = DateTime.now();

    if (now.isAfter(consultationStartTime) ||
        now.isAtSameMomentAs(consultationStartTime)) {
      canEdit.value = true;
      _timer?.cancel();
    }
  }

  @override
  void onInit() {
    super.onInit();
    descController.text = arg['description'];
    probController.text = arg['problem'];
    sumController.text = arg['summary'];
    try {
      final schedule = arg['schedule'];
      final dateStr = schedule['available_date'] as String;
      final timeStr = schedule['start_time'] as String;

      final fullDateTimeStr = "$dateStr $timeStr";
      consultationStartTime = DateTime.parse(fullDateTimeStr);

      _checkSessionStatus();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _checkSessionStatus();
      });
    } catch (e) {
      print("Error parsing consultation time: $e");
      canEdit.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
