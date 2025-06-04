import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  final box = GetStorage();

  SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (box.read('token') == null) {
        Get.offAllNamed(Routes.SIGNIN_PAGE);
      } else {
        Get.offAllNamed(Routes.NAVIGATION_BAR, arguments: {'indexPage': 0});
      }
    });
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/app_logo.png',
            scale: 2,
          ),
          szbY16,
          Text(
            'Teman Bicara',
            style: h3Bold.copyWith(color: primaryColor),
          )
        ],
      )),
    );
  }
}
