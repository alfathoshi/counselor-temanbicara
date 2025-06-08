// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_if_null_operators

import 'package:counselor_temanbicara/app/modules/home/views/home_view.dart';
import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/widgets/consult_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        onRefresh: controller.fetchData,
        child: Obx(() {
          final listPatient = controller.consultList;

          if (controller.isLoading.value) {
            return ListView.builder(
                itemCount: listPatient.length,
                itemBuilder: (context, index) {
                  final data = listPatient[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: shimmerLoader(
                      ConsultCard(
                        image: data['user']['profile_url'],
                        name: data['user']['name'],
                        problem: data['problem'],
                        date: data['schedule']['available_date'],
                        start: data['schedule']['start_time'],
                        end: data['schedule']['end_time'],
                        status: data['status'],
                      ),
                    ),
                  );
                });
          } else if (listPatient.isEmpty) {
            return ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: Get.height * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/empty_consult.png',
                        scale: 5,
                      ),
                      Text(
                        "No consultations yet.",
                        textAlign: TextAlign.center,
                        style: h5Medium,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listPatient.length,
              itemBuilder: (context, index) {
                final data = listPatient[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.CONSULTATION_DETAIL, arguments: data);
                      controller.box
                          .write('consultation_id', data['consultation_id']);
                    },
                    child: ConsultCard(
                      image: data['user']['profile_url'],
                      name: data['user']['name'],
                      problem: data['problem'],
                      date: data['schedule']['available_date'],
                      start: data['schedule']['start_time'],
                      end: data['schedule']['end_time'],
                      status: data['status'],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
