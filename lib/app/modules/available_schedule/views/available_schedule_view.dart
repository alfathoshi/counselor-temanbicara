// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../themes/fonts.dart';
import '../controllers/available_schedule_controller.dart';

class AvailableScheduleView extends GetView<AvailableScheduleController> {
  const AvailableScheduleView({Key? key}) : super(key: key);

  final bool schedule = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          size: 32,
        ),
        title: Text(
          'Available Schedule',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
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
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final List<DateTime>? dateTime =
                            await showOmniDateTimeRangePicker(
                          context: context,
                          isForceEndDateAfterStartDate: true,
                        );
                        debugPrint('dateTime: $dateTime');
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
                              Text('Select Date', style: h3Regular),
                              Icon(
                                Icons.keyboard_arrow_down,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // TextField(
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(color: primaryColor, width: 1),
                    //       borderRadius: BorderRadius.circular(16),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: primaryColor, width: 1),
                    //       borderRadius: BorderRadius.circular(16),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: primaryColor, width: 1),
                    //       borderRadius: BorderRadius.circular(16),
                    //     ),
                    //     hintText: "Input Day",
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 24,
                    // ),
                    // TextField(
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(color: primaryColor, width: 1),
                    //       borderRadius: BorderRadius.circular(16),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: primaryColor, width: 1),
                    //       borderRadius: BorderRadius.circular(16),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: primaryColor, width: 1),
                    //       borderRadius: BorderRadius.circular(16),
                    //     ),
                    //     hintText: "Input Time",
                    //   ),
                    // ),
                    SizedBox(
                      height: 24,
                    ),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor),
                          foregroundColor:
                              MaterialStateProperty.all(whiteColor),
                          fixedSize: WidgetStatePropertyAll(Size(165, 33))),
                      onPressed: () {},
                      child: Text(
                        "Confirm",
                        style: h5Bold.copyWith(color: whiteColor),
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
            schedule
                ? Container(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Monday",
                                style: h4Bold,
                              ),
                              Text(
                                "Available Time",
                                style: h6Bold,
                              ),
                              Text(
                                "07.30 - 10.00",
                                style: h6Medium,
                              ),
                              Text(
                                "13.00 - 15.30",
                                style: h6Medium,
                              ),
                            ],
                          ),
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(primaryColor),
                                foregroundColor:
                                    MaterialStateProperty.all(whiteColor),
                                fixedSize:
                                    WidgetStatePropertyAll(Size(111, 33))),
                            onPressed: () {},
                            child: Text(
                              "Edit",
                              style: h5Bold.copyWith(color: whiteColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Center(
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
                  ),
          ],
        ),
      ),
    );
  }
}
