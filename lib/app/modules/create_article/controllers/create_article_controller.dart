import 'dart:io';
import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import '../../../config/config.dart';

class CreateArticleController extends GetxController {
  final QuillController quillController = QuillController.basic();
  final TextEditingController title = TextEditingController();
  final box = GetStorage();

  var pickedImage = Rx<File?>(null);
  var profileUrl = "".obs;
  var isLoading = false.obs;

  Future<void> submitArticle() async {
    if (title.text.isEmpty || quillController.document.toPlainText().isEmpty) {
      Get.snackbar('Error', 'Title and Body are required',
          backgroundColor: Colors.red.withValues(alpha: 0.6),
          colorText: Colors.white);
      return;
    }

    try {
      showLoadingDialog();
      final token = box.read('token');

      var uri = Uri.parse('${Config.apiEndPoint}/article');
      var request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['title'] = title.text;
      request.fields['content'] = quillController.document.toPlainText();

      if (pickedImage.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          pickedImage.value!.path,
        ));
      }

      var response = await request.send();
      final res = await http.Response.fromStream(response);
      final data = json.decode(res.body);

      if (data['status'] == true) {
        title.clear();
        quillController.clear();

        pickedImage.value = null;
        showSuccessDialog(data['message'] ?? 'Article created successfully');
      } else {
        Get.back();
        Get.snackbar('Error', 'Failed to create article');
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    try {
      PermissionStatus status;

      if (Platform.isAndroid) {
        status = await Permission.photos.request();
        if (status.isDenied || status.isPermanentlyDenied) {
          status = await Permission.storage.request();
        }
      } else {
        status = await Permission.photos.request();
      }

      if (!status.isGranted) {
        Get.snackbar(
          'Permission Denied',
          'Akses ke galeri ditolak.',
          backgroundColor: Colors.red.withValues(alpha: 0.6),
          colorText: Colors.white,
        );
        return;
      }

      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      pickedImage.value = File(pickedFile.path);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal ambil gambar.',
        backgroundColor: Colors.red.withValues(alpha: 0.6),
        colorText: Colors.white,
      );
    }
  }

  void showLoadingDialog() {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
  }

  void showSuccessDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('Berhasil'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.offAllNamed(Routes.NAVIGATION_BAR,
                  arguments: {"indexPage": 1});
            },
            child: const Text('Oke'),
          ),
        ],
      ),
    );
  }
}
