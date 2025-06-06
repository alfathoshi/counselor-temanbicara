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
        title: 'Report sent',
        message: 'Your report has sent',
        status: true,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    descController.text = arg['description'];
    probController.text = arg['problem'];
    sumController.text = arg['summary'];
  }
}
