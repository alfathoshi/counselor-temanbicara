import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateArticleController extends GetxController {
  final QuillController quillController = QuillController.basic();
  final TextEditingController title = TextEditingController();
  final box = GetStorage();
  final count = 0.obs;
    Future<void> submitArticle() async {
    if (title.text.isEmpty || quillController.document.toPlainText().isEmpty) {
      Get.snackbar('Error', 'Title and Body are required',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final Map<String, dynamic> data = {
      'title': title.text,
      'content': quillController.document.toPlainText(),
      'image' : 'ds'
    };
    print(data);

    try {
      final userId = box.read('id');
      final token = box.read('token');
 
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/v1/article'),
        
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'title': data['title'],
          'content': data['content'],
          'image': data['image'],
          'user_id': userId.toString(),
        },
      );

      if (response.statusCode == 200) {

        Get.snackbar('Success', 'article created successfully',
            snackPosition: SnackPosition.BOTTOM);
        title.clear();
        quillController.clear();
      } else {
        print(response.body);
        var errorData = jsonDecode(response.body);
        print(errorData);
        Get.snackbar(
            'Error', errorData['message'] ?? 'Failed to create article',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
