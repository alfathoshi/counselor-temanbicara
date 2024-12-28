// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/consultation_detail_controller.dart';

class ConsultationDetailView extends GetView<ConsultationDetailController> {
  ConsultationDetailView({Key? key}) : super(key: key);
  final bool status = false;
  final Map<String, dynamic> patient = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "Patient's Profile",
          style: h3Bold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(
                Icons.save,
                size: 32,
                color: primaryColor,
              ),
              onPressed: () {
                controller.updateReport();
              },
            ),
          )
        ],
        centerTitle: true,
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
                        radius: 61,
                        backgroundColor: whiteColor,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      patient['general_user_name'],
                      style: h3Bold,
                    ),
                    Text(
                      'Age : ${controller.calculateAge(patient['birthdate'])} y.o',
                      style: h3Regular,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      patient['consultations']['status'],
                      style: h5Bold.copyWith(
                        color: whiteColor,
                      ),
                    ),
                  ),
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
