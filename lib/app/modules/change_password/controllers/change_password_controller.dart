import 'dart:convert';

import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../config/config.dart';

class ChangePasswordController extends GetxController {
  final box = GetStorage();
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  var isLoading = false.obs;

  Future<void> changePassword() async {
    isLoading.value = true;

    try {
      final token = box.read('token');

      final response = await http.patch(
        Uri.parse('${Config.apiEndPoint}/change-password'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'old_password': oldPassController.text,
          'new_password': newPassController.text,
          'confirm_password': confirmPassController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        box.write('new_password', responseData['new_password']);

        if (responseData['status']) {
          Get.snackbar(
            'Success',
            'Password has changed successfully',
            backgroundColor: primaryColor.withValues(alpha: 0.6),
            colorText: whiteColor,
          );
        } else {
          Get.snackbar(
            'Error',
            responseData['message'] ?? 'Failed to update password 1',
            backgroundColor: error.withValues(alpha: 0.6),
            colorText: whiteColor,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to update password.',
          backgroundColor: error.withValues(alpha: 0.6),
          colorText: whiteColor,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: error.withValues(alpha: 0.6),
        colorText: whiteColor,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
