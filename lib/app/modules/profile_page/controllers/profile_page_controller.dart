import 'dart:convert';

import 'package:counselor_temanbicara/app/config/config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProfilePageController extends GetxController {
  GetStorage box = GetStorage();
  var profile = {}.obs;

  Future<void> fetchProfile() async {
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
    } else {
      throw Exception('Failed to load profile');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
