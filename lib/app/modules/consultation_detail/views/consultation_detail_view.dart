// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/consultation_detail_controller.dart';

class ConsultationDetailView extends GetView<ConsultationDetailController> {
  final bool status = false;
  final Map<String, dynamic> patient = Get.arguments;

  ConsultationDetailView({super.key});
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
          'Patient',
          style: h3Bold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
                onPressed: () {
                  controller.updateReport();
                  Get.offAllNamed(Routes.NAVIGATION_BAR,
                      arguments: {"indexPage": 2});
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
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: primaryColor,
                          width: 1,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.grey.shade300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(patient["user"]['profile_url']),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      patient['user']['name'],
                      style: h3Bold,
                    ),
                    Text(
                      '${controller.calculateAge(patient['user']['birthdate'])} y.o',
                      style: h5Regular,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Problem',
                style: h3Bold,
              ),
              SizedBox(
                height: 100,
                width: double.infinity,
                child: TextField(
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
              SizedBox(
                height: 16,
              ),
              Text(
                'Description',
                style: h3Bold,
              ),
              SizedBox(
                height: 100,
                width: double.infinity,
                child: TextField(
                  controller: controller.descController,
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
              SizedBox(
                height: 16,
              ),
              Text(
                'Summary',
                style: h3Bold,
              ),
              SizedBox(
                height: 100,
                width: double.infinity,
                child: TextField(
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
