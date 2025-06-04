import 'dart:convert';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../config/config.dart';

class AvailableScheduleController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  final box = GetStorage();
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  var isLoading = false.obs;
  var isSelect = false.obs;
  var scheduleList = [].obs;
  var eventDates = <DateTime>[].obs;
  Rxn<TimeOfDay> selectedTime = Rxn<TimeOfDay>();
  Rxn<int> selectedDuration = Rxn<int>();

  List<dynamic> get scheduleBySelectedDate {
    return scheduleList.firstWhereOrNull((s) =>
            s['date'] ==
            DateFormat('yyyy-MM-dd')
                .format(selectedDate.value))?['schedulesByDate'] ??
        [];
  }

  void loadScheduleEventsFromApi() {
    eventDates.value = scheduleList.map((item) {
      final date = DateTime.parse(item['date']);
      return DateTime(date.year, date.month, date.day);
    }).toList();
  }

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
      final token = box.read('token');

      var response = await http.get(
        Uri.parse('${Config.apiEndPoint}/schedule/${box.read('id')}/get'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status']) {
          scheduleList.value = data['data']['schedules'];
          loadScheduleEventsFromApi();
        } else {
          Get.snackbar('Error', data['message'],
              backgroundColor: Colors.red.withValues(alpha: 0.6),
              colorText: Colors.white);
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch schedules.',
            backgroundColor: Colors.red.withValues(alpha: 0.6),
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e',
          backgroundColor: Colors.red.withValues(alpha: 0.6),
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createSchedule() async {
    final selectedDate = this.selectedDate.value;
    final selectedTime = this.selectedTime.value;
    final duration = selectedDuration.value;

    // ignore: unnecessary_null_comparison
    if (selectedDate == null || selectedTime == null || duration == null) {
      Get.snackbar(
        'Error',
        'Please select date, time, and duration.',
        backgroundColor: Colors.red.withValues(alpha: 0.6),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final userId = box.read('id');
      final token = box.read('token');

      // Combine selectedDate + selectedTime jadi DateTime full
      final startDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      final endDateTime = startDateTime.add(Duration(minutes: duration));

      String availableDate = DateFormat('yyyy-MM-dd').format(startDateTime);
      String startTime = DateFormat('HH:mm').format(startDateTime);
      String endTime = DateFormat('HH:mm').format(endDateTime);

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

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['status']) {
          Get.snackbar(
            'Success',
            'Schedule created successfully.',
            backgroundColor: Colors.green.withValues(alpha: 0.6),
            colorText: Colors.white,
          );

          await fetchSchedules();
          Get.back();
        } else {
          Get.snackbar(
            'Error',
            data['message'],
            backgroundColor: Colors.red.withValues(alpha: 0.6),
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to create schedule.',
          backgroundColor: Colors.red.withValues(alpha: 0.6),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        backgroundColor: Colors.red.withValues(alpha: 0.6),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, dynamic> getStatusConfig(String status) {
    switch (status) {
      case 'Available':
        return {'icon': Icons.check_circle_outline, 'color': info};
      case 'Booked':
        return {'icon': Icons.pending_actions, 'color': warning};
      case 'Done':
        return {'icon': Icons.cancel_outlined, 'color': primaryColor};
      default:
        return {'icon': Icons.help_outline, 'color': Colors.grey};
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchSchedules();
  }
}
