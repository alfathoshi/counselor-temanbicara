// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_if_null_operators

import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:counselor_temanbicara/app/widgets/consult_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../themes/colors.dart';
import '../controllers/counsultation_page_controller.dart';

class CounsultationPageView extends GetView<CounsultationPageController> {
  const CounsultationPageView({super.key});
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
          'Consultation',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: primaryColor,
        backgroundColor: whiteColor,
        onRefresh: () {
          return controller.fetchData();
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Obx(() {
            if (controller.consultList.isEmpty) {
              return Center(child: Text("Tidak Ada Data"));
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.consultList.length,
              itemBuilder: (context, index) {
                final listPatient = controller.consultList;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.CONSULTATION_DETAIL,
                          arguments: listPatient[index]);
                      controller.box.write('consultation_id',
                          listPatient[index]['consultation_id']);
                    },
                    child: ConsultCard(
                      image: listPatient[index]['user']['profile_url'],
                      name: listPatient[index]['user']['name'],
                      problem: listPatient[index]['problem'],
                      date: listPatient[index]['schedule']['available_date'],
                      start: listPatient[index]['schedule']['start_time'],
                      end: listPatient[index]['schedule']['end_time'],
                      status: listPatient[index]['status'],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
