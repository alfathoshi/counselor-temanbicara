import 'package:get/get.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
class ArticlePageController extends GetxController {
  //TODO: Implement ArticlePageController
  final box = GetStorage();
  var isLoading = false.obs;
  var articleList = [].obs;

  Future<Map<String, dynamic>> fetchArticles() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/v1/articleById'),
      headers: {'Authorization': 'Bearer ${box.read('token')}'},
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      articleList.value = data['data'];
      return data;
      // return json.decode(response.body);
    } else {
      throw Exception('Failed to load schedule');
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
