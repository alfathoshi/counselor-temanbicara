import 'package:get/get.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
class ArticlePageController extends GetxController {
  //TODO: Implement ArticlePageController
  final box = GetStorage();
  var isLoading = false.obs;
  var articleList = [].obs;

  Future<void> fetchArticles() async {
    isLoading.value = true;
    try {
      final userId = box.read('id');
      final articleId = box.write('artikel_id', 'artikel_id');
      print("dddas ${userId}");
      final token = box.read('token');
      print(articleList);
      print("token  ${token}");
      var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/v1/articleById')
            .replace(queryParameters: {
          'userId': userId.toString(),
        }),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status']) {
          articleList.value = data['data'];
        } else {
          Get.snackbar('Error', data['message']);
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch articles.');
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
