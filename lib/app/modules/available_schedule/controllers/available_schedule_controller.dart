import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AvailableScheduleController extends GetxController {
  final box = GetStorage();
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  var isLoading = false.obs;
  var isSelect = false.obs;
  var scheduleList = [].obs;

  String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  void updateDates(List<DateTime>? dates) {
    if (dates != null && dates.length == 2) {
      startDate.value = dates[0];
      endDate.value = dates[1];
    }
  }

  String getDayName(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('EEEE').format(dateTime);
  }

  Future<void> fetchSchedules() async {
    isLoading.value = true;
    try {
      final userId = box.read('id');
      print(userId);
      final token = box.read('token');

      var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/v1/schedule/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status']) {
          scheduleList.value = data['data']['schedules'];
        } else {
          Get.snackbar('Error', data['message'],
              backgroundColor: Colors.red.withOpacity(0.6),
              colorText: Colors.white);
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch schedules.',
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
        Uri.parse('http://10.0.2.2:8000/api/v1/schedule'),
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
          fetchSchedules();
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

  @override
  void onInit() {
    super.onInit();
    fetchSchedules();
  }
}
