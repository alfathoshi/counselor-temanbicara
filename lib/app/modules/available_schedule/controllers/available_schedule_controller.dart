import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AvailableScheduleController extends GetxController {
  // String formatDate(DateTime dateTime) {
  //   return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  // }

  final box = GetStorage();
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  var isLoading = false.obs;
  var scheduleList = [].obs;

  void updateDates(List<DateTime>? dates) {
    if (dates != null && dates.length == 2) {
      startDate.value = dates[0];
      endDate.value = dates[1];
    }
  }

  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  String getDayName(String date) {
    // Konversi string ke DateTime
    DateTime dateTime = DateTime.parse(date);
    // Format ke nama hari
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

  @override
  void onInit() {
    fetchSchedules();
    super.onInit();
  }
}
