import 'dart:convert';

import 'package:counselor_temanbicara/app/config/config.dart';
import 'package:counselor_temanbicara/app/modules/article_page/controllers/article_page_controller.dart';
import 'package:counselor_temanbicara/app/modules/counsultation_page/controllers/counsultation_page_controller.dart';
import 'package:counselor_temanbicara/app/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final CounsultationPageController consult = Get.find();
  final ArticlePageController article = Get.find();

  var profile = {}.obs;

  GetStorage box = GetStorage();

  Future<void> fetchProfile() async {
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
    } else {
      CustomSnackbar.showSnackbar(
        title: 'Oops!',
        message: 'Can not load profile',
        status: false,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    consult.fetchData();
    article.fetchArticles(page: 1, isInitialLoad: true);
  }
}
