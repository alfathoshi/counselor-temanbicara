import 'package:counselor_temanbicara/app/modules/available_schedule/controllers/available_schedule_controller.dart';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class SchedulePicker {
  final AvailableScheduleController controller =
      Get.put(AvailableScheduleController());

  Future<void> pickDate(BuildContext? context) async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context!,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
      title: Text(
        'Select Date',
        style: h4Bold,
      ),
      is24HourMode: true,
      barrierDismissible: false,
      type: OmniDateTimePickerType.date,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
      ),
      padding: const EdgeInsets.all(16),
      transitionDuration: const Duration(milliseconds: 200),
    );
    controller.selectedDate.value = dateTime!;
  }

  Future<void> pickTime(BuildContext? context) async {
    DateTime? dateTime = await showOmniDateTimePicker(
        context: context!,
        initialDate: controller.selectedDate.value,
        firstDate: controller.selectedDate.value,
        lastDate: controller.selectedDate.value,
        title: Text(
          'Select Time',
          style: h4Bold,
        ),
        is24HourMode: true,
        type: OmniDateTimePickerType.time,
        minutesInterval: 15,
        barrierDismissible: false,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: primaryColor,
            onPrimary: Colors.white,
            surface: Colors.white,
          ),
        ),
        padding: const EdgeInsets.all(16));
    controller.selectedTime.value = TimeOfDay.fromDateTime(dateTime!);
  }

  Future<void> pickDuration(BuildContext context) async {
    final controller = Get.find<AvailableScheduleController>();

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          title: Text(
            'Select Duration',
            style: h4Bold,
          ),
          content: Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [15, 30, 45, 60, 90].map((duration) {
                return RadioListTile<int>(
                  value: duration,
                  groupValue: controller.selectedDuration.value,
                  title: Text('$duration minutes'),
                  activeColor: primaryColor,
                  onChanged: (value) {
                    controller.selectedDuration.value = value!;
                  },
                );
              }).toList(),
            );
          }),
          actions: [
            TextButton(
              onPressed: () {
                controller.selectedDuration.value = null;
                Get.back();
              },
              child: Text(
                'Cancel',
                style: buttonLinkSBold.copyWith(color: grey3Color),
              ),
            ),
            Obx(() => TextButton(
                  onPressed: controller.selectedDuration.value != 0
                      ? () => Get.back()
                      : null,
                  child: Text(
                    'Ok',
                    style: buttonLinkSBold.copyWith(color: primaryColor),
                  ),
                )),
          ],
        );
      },
    );
  }
}
