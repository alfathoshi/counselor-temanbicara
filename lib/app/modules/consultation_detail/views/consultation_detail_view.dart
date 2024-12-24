// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/consultation_detail_controller.dart';

class ConsultationDetailView extends GetView<ConsultationDetailController> {
  const ConsultationDetailView({Key? key}) : super(key: key);
  final bool status = false;
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
              onPressed: () {},
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Padding(
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
                    'Bunga Floriska',
                    style: h3Bold,
                  ),
                  Text(
                    'Age : 20 y.o',
                    style: h3Regular,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            status
                ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Done',
                          style: h5Bold.copyWith(
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Upcoming',
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
            Text(
              'Have a sleep problem, anxiety, and overthinking',
              style: h6Regular,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Summary',
              style: h3Bold,
            ),
            Text(
              'Have a sleep problem, anxiety, and overthinking',
              style: h6Regular,
            ),
          ],
        ),
      ),
    );
  }
}
