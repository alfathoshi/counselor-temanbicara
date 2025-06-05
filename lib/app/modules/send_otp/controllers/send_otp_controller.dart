import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../../../config/config.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_snackbar.dart';

class SendOtpController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isButtonActive = true.obs;
  TextEditingController emailController = TextEditingController();

  bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  Future<void> sendOtp() async {
    isLoading.value = true;
    try {
      if (!validateEmail(emailController.text)) {
        isLoading.value = false;
        CustomSnackbar.showSnackbar(
          title: "Invalid!",
          message: "Invalid Email!",
          status: false,
        );
        return;
      }

      var response = await http.post(
        Uri.parse("${Config.apiEndPoint}/password/otp"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': emailController.text,
        }),
      );

      var data = json.decode(response.body);
      if (!data['status']) {
        CustomSnackbar.showSnackbar(
          title: "Invalid!",
          message: "Email is not Recognized!",
          status: false,
        );
        isLoading.value = false;
        return;
      }

      if (!isButtonActive.value) {
        CustomSnackbar.showSnackbar(
          title: "Request Sent!",
          message: "Please Check your Email!",
          status: true,
        );
        isLoading.value = false;
        Get.toNamed(
          Routes.VERIFY_O_T_P,
          arguments: {
            "email": emailController.text,
            "user_id": data!['user_id']
          },
        );
      }
      isLoading.value = false;
      return;
    } catch (err) {
      CustomSnackbar.showSnackbar(
        title: "Oops!",
        message: "Failed to Send OTP!",
        status: false,
      );
    }
  }
}
