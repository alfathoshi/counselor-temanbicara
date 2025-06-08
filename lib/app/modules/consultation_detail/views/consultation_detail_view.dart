// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/consultation_detail_controller.dart';

class ConsultationDetailView extends GetView<ConsultationDetailController> {
  final bool status = false;
  final Map<String, dynamic> patient = Get.arguments;

  ConsultationDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    DateTime formattedDate =
        DateTime.parse(patient['schedule']['available_date']);
    DateTime sTime =
        DateFormat('HH:mm:ss').parse(patient['schedule']['start_time']);
    DateTime eTime =
        DateFormat('HH:mm:ss').parse(patient['schedule']['end_time']);
    String startTime = DateFormat('HH:mm').format(sTime);
    String endTime = DateFormat('HH:mm').format(eTime);
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
          'Patient',
          style: h3Bold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
                onPressed: () {
                  controller.updateReport();
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(primaryColor),
                  foregroundColor: WidgetStatePropertyAll(whiteColor),
                ),
                child: const Text('Save')),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: border,
                          width: 1,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: NetworkImage(
                          patient["user"]['profile_url'],
                        ),
                      ),
                    ),
                    szbY16,
                    Text(
                      patient['user']['name'],
                      style: h3Bold,
                    ),
                    Text(
                      '${controller.calculateAge(patient['user']['birthdate'])} y.o',
                      style: h5Regular,
                    ),
                    szbY8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.date_range,
                          size: 18,
                          color: font,
                        ),
                        szbX8,
                        Text(DateFormat('d MMMM').format(formattedDate),
                            style: h6Medium),
                        szbX16,
                        const Icon(
                          Icons.schedule_rounded,
                          size: 18,
                          color: font,
                        ),
                        szbX8,
                        Text('$startTime - $endTime', style: h6Medium),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                width: 90,
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1.5),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    "Problem",
                    style: h6SemiBold.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              szbY8,
              SizedBox(
                height: 160,
                width: double.infinity,
                child: TextField(
                  style: h6Regular,
                  controller: controller.probController,
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.text,
                  expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Input here...',
                      hintStyle: h7Regular,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: border)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: border))),
                ),
              ),
              szbY16,
              Container(
                width: 90,
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1.5),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    "Description",
                    style: h6SemiBold.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              szbY8,
              SizedBox(
                height: 160,
                width: double.infinity,
                child: TextField(
                  controller: controller.descController,
                  style: h6Regular,
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.text,
                  expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Input here...',
                      hintStyle: h7Regular,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: border)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: border))),
                ),
              ),
              szbY16,
              Container(
                width: 90,
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1.5),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    "Summary",
                    style: h6SemiBold.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              szbY8,
              SizedBox(
                height: 160,
                width: double.infinity,
                child: TextField(
                  style: h6Regular,
                  controller: controller.sumController,
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.text,
                  expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Input here...',
                      hintStyle: h7Regular,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: border)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: border))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
