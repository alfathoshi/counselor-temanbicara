// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/edit_schedule_controller.dart';

class EditScheduleView extends GetView<EditScheduleController> {
  const EditScheduleView({Key? key}) : super(key: key);
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
          'Edit Schedule',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Monday',
                          style: h3Bold,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "07.30 - 10.00",
                          style: h5Medium,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "13.00 - 15.30",
                          style: h5Medium,
                        ),
                      ],
                    ),
                    Icon(
                      Icons.do_not_disturb_on,
                      size: 32,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                  foregroundColor: MaterialStateProperty.all(whiteColor),
                  fixedSize: WidgetStatePropertyAll(Size(165, 33))),
              onPressed: () {},
              child: Text("Confirm", style: h5Bold.copyWith(color: whiteColor),),
            ),
          ],
        ),
      ),
    );
  }
}
