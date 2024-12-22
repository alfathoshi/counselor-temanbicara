import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

class CreateArticleController extends GetxController {
  final QuillController quillController = QuillController.basic();

  final count = 0.obs;
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
