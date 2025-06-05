// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:counselor_temanbicara/app/widgets/custom_snackbar.dart';
import 'package:counselor_temanbicara/app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/edit_schedule_controller.dart';

class EditScheduleView extends GetView<EditScheduleController> {
  const EditScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    void pickDate(BuildContext context) async {
      DateTime? dateTime = await showOmniDateTimePicker(
        context: context,
        initialDate: DateTime.now().add(const Duration(days: 1)),
        firstDate: DateTime.now().add(const Duration(days: 1)),
        lastDate: DateTime.now().add(
          const Duration(days: 365),
        ),
        is24HourMode: false,
        isShowSeconds: false,
        type: OmniDateTimePickerType.date,
        minutesInterval: 1,
        secondsInterval: 1,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        constraints: const BoxConstraints(
          maxWidth: 350,
          maxHeight: 650,
        ),
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
      );
      controller.selectedDate.value = dateTime;
    }

    void pickTime(BuildContext context) async {
      DateTime? dateTime = await showOmniDateTimePicker(
        context: context,
        initialDate: DateTime.now().add(const Duration(days: 1)),
        firstDate: DateTime.now().add(const Duration(days: 1)),
        lastDate: DateTime.now().add(
          const Duration(days: 365),
        ),
        is24HourMode: false,
        isShowSeconds: false,
        type: OmniDateTimePickerType.time,
        minutesInterval: 1,
        secondsInterval: 1,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        constraints: const BoxConstraints(
          maxWidth: 350,
          maxHeight: 650,
        ),
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
      );
      controller.selectedTime.value = TimeOfDay.fromDateTime(dateTime!);
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
              onTap: () => pickDate(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
              onTap: () => pickTime(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
                      onSelected: (_) =>
                          controller.selectedDuration.value = dur,
                      selectedColor: Colors.blueAccent,
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    );
                  }).toList(),
                )),
            const SizedBox(height: 24),
            MyButton(
                get: () {
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
                    CustomSnackbar.showSnackbar(
                      title: 'Oops!',
                      message: 'Please fill all fields',
                      status: false,
                    );
                  }
                },
                color: primaryColor,
                text: 'Create')
          ],
        ),
      ),
    );
  }
}
