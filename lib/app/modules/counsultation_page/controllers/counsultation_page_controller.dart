import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../../../config/config.dart';

class CounsultationPageController extends GetxController {
  final box = GetStorage();
  var consultList = [].obs;
  var eventDates = <DateTime>[].obs;
  var isLoading = false.obs;

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('${Config.apiEndPoint}/consultation/counselor'),
        headers: {'Authorization': 'Bearer ${box.read('token')}'},
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        consultList.value = data['data'];
        loadEventsFromApi();
      } else {
        throw Exception('Failed to load consultation');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void loadEventsFromApi() {
    eventDates.value =
        consultList.where((item) => item['status'] == 'Incoming').map((item) {
      final date = DateTime.parse(item['schedule']['available_date']);
      return DateTime(date.year, date.month, date.day);
    }).toList();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }
}
