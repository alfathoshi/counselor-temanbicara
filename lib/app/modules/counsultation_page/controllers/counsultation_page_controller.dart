import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class CounsultationPageController extends GetxController {
  final box = GetStorage();
  var consultList = [].obs;

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/v1/consultation-counselor'),
      headers: {'Authorization': 'Bearer ${box.read('token')}'},
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      consultList.value = data['data'];
      return data;
      // return json.decode(response.body);
    } else {
      throw Exception('Failed to load schedule');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }
}
