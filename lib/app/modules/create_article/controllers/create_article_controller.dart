import 'dart:io';
import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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
      CustomSnackbar.showSnackbar(
        title: 'Invalid Data',
        message: 'Please fill the content',
        status: false,
      );
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
      } else {
        final byteData = await rootBundle.load('assets/images/app_icon.png');

        final tempDir = await getTemporaryDirectory();
        final tempFile = File('${tempDir.path}/default_image.png');
        await tempFile.writeAsBytes(byteData.buffer.asUint8List());

        request.files.add(await http.MultipartFile.fromPath(
          'image',
          tempFile.path,
        ));
      }

      var response = await request.send();
      final res = await http.Response.fromStream(response);
      final data = json.decode(res.body);

      if (data['status'] == true) {
        title.clear();
        quillController.clear();

        pickedImage.value = null;
        CustomSnackbar.showSnackbar(
          title: 'Yeay!',
          message: 'Article created',
          status: true,
        );
        Get.offAllNamed(
          Routes.NAVIGATION_BAR,
          arguments: {"indexPage": 1},
        );
      } else {
        Get.back();
        CustomSnackbar.showSnackbar(
          title: 'Oops!',
          message: 'No article created',
          status: false,
        );
      }
    } catch (e) {
      Get.back();
      CustomSnackbar.showSnackbar(
        title: 'Oops!',
        message: 'No article created',
        status: false,
      );
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
        CustomSnackbar.showSnackbar(
          title: 'Oops!',
          message: 'Permission denied',
          status: false,
        );
        return;
      }

      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      pickedImage.value = File(pickedFile.path);
    } catch (e) {
      CustomSnackbar.showSnackbar(
        title: 'Oops!',
        message: 'Can not pick image',
        status: false,
      );
    }
  }

  void showLoadingDialog() {
    Get.dialog(
      Center(
          child: CircularProgressIndicator(
        color: primaryColor,
      )),
      barrierDismissible: false,
    );
  }
}
