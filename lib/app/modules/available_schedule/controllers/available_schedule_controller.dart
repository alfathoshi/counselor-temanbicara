import 'dart:convert';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/widgets/custom_snackbar.dart';
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
          CustomSnackbar.showSnackbar(
            title: 'Oops!',
            message: 'Can not load schedule',
            status: false,
          );
        }
      } else {
        CustomSnackbar.showSnackbar(
          title: 'Try again',
          message: 'Can not fetch schedule',
          status: false,
        );
      }
    } catch (e) {
      CustomSnackbar.showSnackbar(
        title: 'Something went wrong',
        message: 'Can not fetch schedule',
        status: false,
      );
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
      CustomSnackbar.showSnackbar(
        title: 'Invalid Data',
        message: 'Fill the data',
        status: false,
      );
      return;
    }

    isLoading.value = true;

    try {
      final userId = box.read('id');
      final token = box.read('token');

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
          CustomSnackbar.showSnackbar(
            title: 'Schedule Created',
            message: 'New schedule added',
            status: true,
          );

          await fetchSchedules();
          Get.back();
        } else {
          CustomSnackbar.showSnackbar(
            title: 'Oops!',
            message: 'Failed to create schedule',
            status: false,
          );
        }
      } else {
        CustomSnackbar.showSnackbar(
          title: 'Oops!',
          message: 'Failed to create schedule',
          status: false,
        );
      }
    } catch (e) {
      CustomSnackbar.showSnackbar(
        title: 'Oops!',
        message: 'Failed to create schedule',
        status: false,
      );
    } finally {
      isLoading.value = false;
      selectedDuration.value = null;
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

  bool isScheduleConflicted() {
    final newStart = DateTime(
      selectedDate.value.year,
      selectedDate.value.month,
      selectedDate.value.day,
      selectedTime.value!.hour,
      selectedTime.value!.minute,
    );
    final newEnd = newStart.add(Duration(minutes: selectedDuration.value!));
    for (var schedule in scheduleList) {
      final scheduleDate = DateTime.parse(schedule['date']);
      if (DateUtils.isSameDay(scheduleDate, selectedDate.value)) {
        final List<dynamic> items = schedule['schedulesByDate'];
        for (var item in items) {
          final start = DateFormat("HH:mm").parse(item['start_time']);
          final end = DateFormat("HH:mm").parse(item['end_time']);

          final existingStart = DateTime(
            scheduleDate.year,
            scheduleDate.month,
            scheduleDate.day,
            start.hour,
            start.minute,
          );

          final existingEnd = DateTime(
            scheduleDate.year,
            scheduleDate.month,
            scheduleDate.day,
            end.hour,
            end.minute,
          );

          final isOverlap =
              newStart.isBefore(existingEnd) && newEnd.isAfter(existingStart);
          final isClose =
              newStart.difference(existingEnd).inMinutes.abs() < 15 ||
                  newEnd.difference(existingStart).inMinutes.abs() < 15;

          if (isOverlap || isClose) return true;
        }
      }
    }
    return false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchSchedules();
  }
}
