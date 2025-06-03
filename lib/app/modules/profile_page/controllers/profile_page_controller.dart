import 'dart:convert';

import 'package:counselor_temanbicara/app/config/config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProfilePageController extends GetxController {
  GetStorage box = GetStorage();
  var profile = {}.obs;
  var isLoading = false.obs;

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
  }

  @override
  void onReady() {
    fetchProfile();
    super.onReady();
  }

  @override
  void onClose() {}
}
