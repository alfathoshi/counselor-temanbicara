import 'package:counselor_temanbicara/app/modules/edit_schedule/controllers/edit_schedule_controller.dart';
import 'package:counselor_temanbicara/app/widgets/date/schedule_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SchedulePicker extends StatelessWidget {
  final EditScheduleController controller = Get.put(EditScheduleController());
  SchedulePicker({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Column(
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

              debugPrint('Start: $start');
              debugPrint('End: $end');

              controller.createSchedule();
            } else {
              Get.snackbar('Oops', 'Lengkapi dulu bro semua field-nya');
            }
          },
          child: const Text('Buat Jadwal'),
        ),
      ],
    );
  }
}
