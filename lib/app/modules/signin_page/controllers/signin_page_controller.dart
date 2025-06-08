import 'dart:convert';

import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../config/config.dart';

class SigninPageController extends GetxController {
  final box = GetStorage();
  late TextEditingController emailC;
  late TextEditingController passC;
  var isButtonActive = true.obs;
  var isSecure = true.obs;
  var isSecureC = true.obs;
  void isEmpty() {
    if (passC.text.isNotEmpty && emailC.text.isNotEmpty) {
      isButtonActive(false);
    } else {
      isButtonActive(true);
    }
  }

  void showPassword() {
    isSecure.value = !isSecure.value;
  }

  void showPasswordC() {
    isSecureC.value = !isSecureC.value;
  }

  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;

    try {
      var response = await http.post(
        Uri.parse('${Config.apiEndPoint}/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status']) {
        if (data['data']['role'] == 'Counselor') {
          box.write('token', data['token']);
          box.write('id', data['data']['id']);
          box.write('name', data['data']['name']);
          box.write('email', data['data']['email']);
          box.write('password', data['data']['password']);
          box.write('phone', data['data']['phone_number']);
          box.write('nickname', data['data']['nickname']);
          box.write('birthdate', data['data']['birthdate']);
          final currentUserID = data['data']['id'].toString();
          await saveFcmToken(currentUserID);
          CustomSnackbar.showSnackbar(
            title: 'Welcome!',
            message: 'Login succesfully',
            status: true,
          );
          Get.offAllNamed(
            Routes.NAVIGATION_BAR,
            arguments: {"indexPage": 0},
          );
        } else {
          CustomSnackbar.showSnackbar(
            title: 'Oops!',
            message: 'Account not registered',
            status: false,
          );
        }
      } else {
        CustomSnackbar.showSnackbar(
          title: 'Oops!',
          message: 'Please try again',
          status: false,
        );
      }
    } catch (e) {
      CustomSnackbar.showSnackbar(
        title: 'Something went wrong',
        message: 'Can not login',
        status: false,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveFcmToken(String userId) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('fcmTokens').doc(userId);

      await docRef.set({
        'tokens': FieldValue.arrayUnion([fcmToken])
      }, SetOptions(merge: true));
    }
  }

  @override
  void onInit() {
    emailC = TextEditingController();
    passC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
