// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../themes/fonts.dart';
import '../controllers/available_schedule_controller.dart';

class AvailableScheduleView extends GetView<AvailableScheduleController> {
  AvailableScheduleView({Key? key}) : super(key: key);
  List<DateTime>? dateTime;
  @override
  Widget build(BuildContext context) {
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
            side: BorderSide(color: Colors.black12)),
        title: Text(
          'Available Schedules',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x4B4B4B26),
                      blurRadius: 16,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          dateTime = await showOmniDateTimeRangePicker(
                              context: context,
                              isForceEndDateAfterStartDate: true,
                              is24HourMode: true,
                              theme: ThemeData());
                          debugPrint('dateTime: $dateTime');
                          controller.updateDates(dateTime);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: primaryColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() => Text(
                                    "${controller.startDate.value != null ? controller.formatDate(controller.startDate.value!) : 'Select Date'}",
                                    style: h3Regular)),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Choosen Date',
                              style: h4Bold,
                            ),
                            Text(
                              "From : ${controller.startDate.value != null ? controller.formatDate(controller.startDate.value!) : ''}",
                              style: h5Medium,
                            ),
                            Text(
                              "To : ${controller.endDate.value != null ? controller.formatDate(controller.endDate.value!) : ''}",
                              style: h5Medium,
                            ),
                          ],
                        );
                      }),
                      SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor),
                              foregroundColor:
                                  MaterialStateProperty.all(whiteColor),
                              fixedSize: WidgetStatePropertyAll(Size(165, 33))),
                          onPressed: () {
                            controller.createSchedule();
                          },
                          child: Text(
                            "Confirm",
                            style: h5Bold.copyWith(color: whiteColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Schedule that already added',
                style: h4Bold,
              ),
              SizedBox(
                height: 24,
              ),
              Obx(() {
                if (controller.scheduleList.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/schedule.png',
                          scale: 2,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'No Schedule',
                          style: h4Bold,
                        ),
                        Text(
                          'There are no schedule',
                          style: h6Medium,
                        ),
                      ],
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: SizedBox(
                    height: 450,
                    child: ListView.builder(
                      itemCount: controller.scheduleList.length,
                      itemBuilder: (context, index) {
                        final schedule = controller.scheduleList[index];
                        return Container(
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x4B4B4B26),
                                blurRadius: 16,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${controller.getDayName(schedule['date'])} ${schedule['date']}",
                                    style: h4Bold),
                                Container(
                                  height: 100,
                                  child: ListView.builder(
                                      itemCount:
                                          schedule['schedulesByDate'].length,
                                      itemBuilder: (context, index) {
                                        List scheduleDay =
                                            schedule['schedulesByDate'];
                                        return Text(
                                            "${scheduleDay[index]['start_time']} - ${scheduleDay[index]['end_time']}");
                                      }),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
