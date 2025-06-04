import 'dart:convert';

import 'package:counselor_temanbicara/app/config/config.dart';
import 'package:counselor_temanbicara/app/modules/available_schedule/controllers/available_schedule_controller.dart';
import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EditScheduleController extends GetxController {
  final box = GetStorage();
  Rxn<DateTime> selectedDate = Rxn<DateTime>();
  Rxn<TimeOfDay> selectedTime = Rxn<TimeOfDay>();
  Rxn<int> selectedDuration = Rxn<int>();
  RxList<Map<String, dynamic>> scheduleList = <Map<String, dynamic>>[].obs;
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  var isLoading = false.obs;

  List<int> durationOptions = [15, 30, 45, 60, 90, 120];

  Future<void> createSchedule() async {
    if (startDate.value == null || endDate.value == null) {
      Get.snackbar('Error', 'Please select start and end dates.',
          backgroundColor: Colors.red.withOpacity(0.6),
          colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      final userId = box.read('id');
      final token = box.read('token');

      String availableDate = DateFormat('yyyy-MM-dd').format(startDate.value!);
      String startTime = DateFormat('HH:mm').format(startDate.value!);
      String endTime = DateFormat('HH:mm').format(endDate.value!);

      var response = await http.post(
        Uri.parse('${Config.apiEndPoint}/schedule'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "available_date": availableDate,
          "start_time": startTime,
          "end_time": endTime,
          "status": "Available",
          "counselor_id": userId,
        }),
      );

      print(response.body);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['status']) {
          Get.snackbar('Success', 'Schedule created successfully.',
              backgroundColor: Colors.green.withOpacity(0.6),
              colorText: Colors.white);
          await AvailableScheduleController().fetchSchedules();
          Get.back();
        } else {
          Get.snackbar('Error', data['message'],
              backgroundColor: Colors.red.withOpacity(0.6),
              colorText: Colors.white);
        }
      } else {
        Get.snackbar('Error', 'Failed to create schedule.',
            backgroundColor: Colors.red.withOpacity(0.6),
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e',
          backgroundColor: Colors.red.withOpacity(0.6),
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
