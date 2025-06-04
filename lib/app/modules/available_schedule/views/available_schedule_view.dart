// ignore_for_file: use_build_context_synchronously

import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/modules/available_schedule/controllers/available_schedule_controller.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:counselor_temanbicara/app/widgets/date/schedule_date.dart';
import 'package:counselor_temanbicara/app/widgets/date/schedule_picker.dart';
import 'package:counselor_temanbicara/app/widgets/status_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';

class AvailableScheduleView extends GetView<AvailableScheduleController> {
  const AvailableScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    SchedulePicker picker = SchedulePicker();
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
          'Available Schedules',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: primaryColor,
        backgroundColor: whiteColor,
        onRefresh: () async {
          await Future.wait([controller.fetchSchedules()]);
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
                child: CircularProgressIndicator(
              color: primaryColor,
              backgroundColor: whiteColor,
            ));
          } else if (controller.scheduleList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/schedule.png', scale: 2),
                  const SizedBox(height: 8),
                  Text('No Schedule', style: h4Bold),
                  Text('There are no schedules', style: h6Medium),
                ],
              ),
            );
          }

          final selectedDate = controller.selectedDate.value;

          final filteredSchedule = controller.scheduleList.firstWhereOrNull(
            (schedule) =>
                DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(schedule['date'])) ==
                DateFormat('yyyy-MM-dd').format(selectedDate),
          );

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              ScheduleDate(
                eventDates: controller.eventDates,
                onDateSelected: (date) {
                  controller.selectedDate.value = date;
                },
                focusedDate: selectedDate,
              ),
              const SizedBox(height: 16),
              if (filteredSchedule == null ||
                  filteredSchedule['schedulesByDate'].isEmpty) ...[
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.event_busy,
                            size: 64, color: grey3Color),
                        szbY8,
                        Text("No schedule for this date", style: h5SemiBold),
                      ],
                    ))
              ] else ...[
                ...List.generate(
                  filteredSchedule['schedulesByDate'].length,
                  (index) {
                    final item = filteredSchedule['schedulesByDate'][index];
                    final start = DateFormat("HH:mm").parse(item['start_time']);
                    final end = DateFormat("HH:mm").parse(item['end_time']);
                    final duration = end.difference(start).inMinutes;
                    final config = controller.getStatusConfig(item['status']);
                    return Card(
                      color: whiteColor,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: whiteScheme)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              duration.toString(),
                              style: h5Bold,
                            ),
                            Text('min',
                                style: h6Regular.copyWith(color: greyColor)),
                          ],
                        ),
                        title: Text(
                          "${DateFormat.Hm().format(start)} - ${DateFormat.Hm().format(end)}",
                          style: h5Medium,
                        ),
                        trailing: StatusChip(
                          status: item['status'],
                          icon: config['icon'],
                          color: config['color'],
                        ),
                      ),
                    );
                  },
                )
              ],
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await picker.pickDate(context);
          await picker.pickTime(context);
          await picker.pickDuration(context);
          if (controller.selectedDuration.value != null) {
            controller.createSchedule();
          }
        },
        shape: const CircleBorder(),
        foregroundColor: whiteColor,
        backgroundColor: primaryColor,
        child: const Icon(Iconsax.add),
      ),
    );
  }
}
