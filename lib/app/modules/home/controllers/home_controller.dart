import 'package:counselor_temanbicara/app/modules/counsultation_page/controllers/counsultation_page_controller.dart';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final consultController = Get.put(CounsultationPageController());
  GetStorage box = GetStorage();

  Future<void> dialog() async {
    
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
