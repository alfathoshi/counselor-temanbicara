import 'dart:convert';
import 'dart:io';

import 'package:counselor_temanbicara/app/config/config.dart';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilePageController extends GetxController {
  GetStorage box = GetStorage();
  var profile = {}.obs;
  var isLoading = false.obs;
  File? storedImage;
  var pickedImage = Rx<File?>(null);

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
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
      }
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changeImage() async {
    try {
      isLoading.value = true;
      final imageFile = pickedImage.value;

      if (imageFile == null) {
        CustomSnackbar.showSnackbar(
          title: 'No Image Selected',
          message: 'Please pick an image first.',
          status: false,
        );
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("https://www.temanbicara.web.id/api/v1/profile/image"),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ),
      );

      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      });

      final response = await request.send();
      final res = await http.Response.fromStream(response);

      if (res.headers['content-type']?.contains('application/json') ?? false) {
        final responseBody = json.decode(res.body);
        // lanjut...
      } else {
        print('⚠️ Response bukan JSON: ${res.statusCode}');
        CustomSnackbar.showSnackbar(
          title: "Server Error",
          message: "Unexpected response from server.",
          status: false,
        );
      }
      final responseBody = json.decode(res.body);

      if (responseBody['status'] == true) {
        CustomSnackbar.showSnackbar(
          title: "Profile Updated!",
          message: "Photo has been updated",
          status: true,
        );
      } else {
        CustomSnackbar.showSnackbar(
          title: "Can not update",
          message: 'Image size too large',
          status: false,
        );
      }

      fetchProfile();
    } catch (err) {
      isLoading.value = false;
      print(err);
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
          title: 'Permission denied',
          message: 'Can not access storage',
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

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  @override
  void onReady() {
    fetchProfile();
    super.onReady();
  }

  @override
  void onClose() {}
}
