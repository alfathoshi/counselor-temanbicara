import 'dart:convert';
import 'package:counselor_temanbicara/app/modules/edit_profile/controllers/datepicker_controller.dart';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class EditProfileController extends GetxController {
  final box = GetStorage();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final DatePickerController dateController = Get.put(DatePickerController());

  var isLoading = false.obs;

  var selectedDate = DateTime.now().obs;
  // void updateDate(DateTime date) {
  //   selectedDate.value = date;
  // }

  var selectedCountry = ''.obs;
  void setCountry(String country) {
    selectedCountry.value = country;
  }

  Future<void> editProfile() async {
    isLoading.value = true;
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(dateController.selectedDate.value);

    try {
      final userId = box.read('id');
      final token = box.read('token');
      print(token);

      final response = await http.put(
        Uri.parse('http://10.0.2.2:8000/api/v1/edit-profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': nameController.text,
          'email': emailController.text,
          'birthdate': formattedDate,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);

        box.write('name', responseData['data']['name']);
        box.write('email', responseData['data']['email']);
        box.write('birthdate', responseData['data']['birthdate']);

        if (responseData['status']) {
          Get.snackbar(
            'Success',
            'Profile updated',
            backgroundColor: primaryColor.withOpacity(0.6),
            colorText: whiteColor,
          );
        } else {
          Get.snackbar(
            'Error',
            responseData['message'] ?? 'Failed to update profile',
            backgroundColor: error.withOpacity(0.6),
            colorText: whiteColor,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to update profile.',
          backgroundColor: error.withOpacity(0.6),
          colorText: whiteColor,
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: error.withOpacity(0.6),
        colorText: whiteColor,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    nameController.text = box.read('name');
    emailController.text = box.read('email');
    DateTime tanggal = DateTime.parse(box.read('birthdate'));
    print('asdas ${box.read('name')}');
    // print(dateController.selectedDate.value);
  }
}
