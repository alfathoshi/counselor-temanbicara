// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_if_null_operators

import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../themes/colors.dart';
import '../controllers/counsultation_page_controller.dart';

class CounsultationPageView extends GetView<CounsultationPageController> {
  final CounsultationPageController controller =
      Get.put(CounsultationPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          'Counsultation',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
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
                    child: Container(
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
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
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
                                    radius: 18,
                                    backgroundColor: whiteColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listPatient[index]['general_user_name'] ??
                                          '',
                                      style: h5Bold,
                                    ),
                                    Text(
                                      listPatient[index]['problem'] != null
                                          ? listPatient[index]['problem']
                                          : '-',
                                      style: h6Medium,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  size: 18,
                                  color: font,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(listPatient[index]['date'] ?? '',
                                    style: h6Medium),
                                SizedBox(
                                  width: 32,
                                ),
                                Icon(
                                  Icons.schedule_rounded,
                                  size: 18,
                                  color: font,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                    '${listPatient[index]['start_time']} - ${listPatient[index]['end_time']}',
                                    style: h6Medium),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    listPatient[index]['status'] ?? '',
                                    style: h5Bold.copyWith(
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
