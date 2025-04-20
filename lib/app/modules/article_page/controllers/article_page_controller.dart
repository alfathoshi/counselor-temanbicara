import 'package:get/get.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../config/config.dart';

class ArticlePageController extends GetxController {
  //TODO: Implement ArticlePageController
  final box = GetStorage();
  var isLoading = false.obs;
  var articleList = [].obs;

  Future<void> fetchArticles() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('${Config.apiEndPoint}/articleById'),
        headers: {'Authorization': 'Bearer ${box.read('token')}'},
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        articleList.value = data['data'];
      } else {
        throw Exception('Failed to load schedule');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    fetchArticles();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
