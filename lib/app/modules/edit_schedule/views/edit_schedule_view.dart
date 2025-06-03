// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:counselor_temanbicara/app/widgets/date/schedule_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/edit_schedule_controller.dart';

class EditScheduleView extends GetView<EditScheduleController> {
  const EditScheduleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void _pickDate(BuildContext context) {
      picker.DatePicker.showDatePicker(
        context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(2100, 12, 31),
        onConfirm: (date) {
          controller.selectedDate.value = date;
        },
        currentTime: DateTime.now(),
        locale: picker.LocaleType.en,
      );
    }

    void _pickTime(BuildContext context) {
      picker.DatePicker.showTimePicker(
        context,
        showTitleActions: true,
        onConfirm: (time) {
          controller.selectedTime.value = TimeOfDay.fromDateTime(time);
        },
        currentTime: DateTime.now(),
        locale: picker.LocaleType.id,
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          side: BorderSide(color: Colors.black12),
        ),
        title: Text(
          'Create Schedules',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Date'),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _pickDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(() {
                  final date = controller.selectedDate.value;
                  return Text(
                    date != null
                        ? DateFormat('EEEE, dd MMM yyyy').format(date)
                        : 'Choose date',
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Time'),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _pickTime(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(() {
                  final time = controller.selectedTime.value;
                  return Text(
                    time != null ? time.format(context) : 'Choose time',
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Duration'),
            const SizedBox(height: 8),
            Obx(() => Wrap(
                  spacing: 12,
                  children: controller.durationOptions.map((dur) {
                    final isSelected = controller.selectedDuration.value == dur;
                    return ChoiceChip(
                      label: Text('$dur menit'),
                      selected: isSelected,
                      onSelected: (_) => controller.selectedDuration.value = dur,
                      selectedColor: Colors.blueAccent,
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    );
                  }).toList(),
                )),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final date = controller.selectedDate.value;
                final time = controller.selectedTime.value;
                final dur = controller.selectedDuration.value;
        
                if (date != null && time != null && dur != null) {
                  final start = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    time.hour,
                    time.minute,
                  );
                  final end = start.add(Duration(minutes: dur));
        
                  controller.startDate.value = start;
                  controller.endDate.value = end;
        
                  controller.createSchedule();
                } else {
                  Get.snackbar('Oops', 'Lengkapi dulu bro semua field-nya');
                }
              },
              child: const Text('Buat Jadwal'),
            ),
          ],
        ),
      ),
    );
  }
}
