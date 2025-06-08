import 'dart:convert';
import 'dart:io';
import 'package:counselor_temanbicara/app/modules/edit_profile/controllers/datepicker_controller.dart';
import 'package:counselor_temanbicara/app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../config/config.dart';

class EditProfileController extends GetxController {
  final box = GetStorage();
  var pickedImage = Rx<File?>(null);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final DatePickerController dateController = Get.put(DatePickerController());

  var isLoading = false.obs;

  var selectedDate = DateTime.now().obs;
  var profile = {}.obs;

  var selectedCountry = ''.obs;
  void setCountry(String country) {
    selectedCountry.value = country;
  }

  Future<void> editProfile() async {
    isLoading.value = true;
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(dateController.selectedDate.value);

    try {
      final token = box.read('token');

      final response = await http.post(
        Uri.parse('${Config.apiEndPoint}/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': nameController.text,
          'email': emailController.text,
          'nickname': nicknameController.text,
          'birthdate': formattedDate,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        box.write('name', responseData['data']['name']);
        box.write('email', responseData['data']['email']);
        box.write('nickname', responseData['data']['nickname']);
        box.write('birthdate', responseData['data']['birthdate']);

        if (responseData['status']) {
          CustomSnackbar.showSnackbar(
            title: 'Profile updated',
            message: 'Your profile has updated',
            status: true,
          );
        } else {
          CustomSnackbar.showSnackbar(
            title: 'Oops!',
            message: 'Can not update profile',
            status: false,
          );
        }
      } else {
        CustomSnackbar.showSnackbar(
          title: 'Try again',
          message: 'Can not update profile',
          status: false,
        );
      }
    } catch (e) {
      CustomSnackbar.showSnackbar(
        title: 'Something went wrong',
        message: 'Can not update profile',
        status: false,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(
          '${Config.apiEndPoint}/profile',
        ),
        headers: {'Authorization': 'Bearer ${box.read('token')}'},
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        profile.value = data['data'];
        box.write('name', profile['name']);
        box.write('email', profile['email']);
        box.write('nickname', profile['nickname']);
        box.write('birthdate', profile['birthdate']);
        json.decode(response.body);
      }
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    nameController.text = box.read('name');
    emailController.text = box.read('email');
    nicknameController.text = box.read('nickname');
    selectedDate.value = DateTime.parse(box.read('birthdate'));
  }
}
