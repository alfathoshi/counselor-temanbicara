import 'package:counselor_temanbicara/app/modules/article_page/controllers/article_page_controller.dart';
import 'package:counselor_temanbicara/app/modules/counsultation_page/controllers/counsultation_page_controller.dart';
import 'package:counselor_temanbicara/app/modules/home/controllers/home_controller.dart';
import 'package:counselor_temanbicara/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:get/get.dart';

class NavigationBarController extends GetxController {
  var args = Get.arguments;
  var selectedindex = 0.obs;

  var selectedPages = 0.obs;

  void changeIndex(int index) {
    selectedindex.value = index;

    // trigger fetch sesuai index tab
    switch (index) {
      case 0:
        Get.find<HomeController>().fetchProfile();
        break;
      case 1:
        Get.find<ArticlePageController>().fetchArticles();
        break;
      case 2:
        Get.find<CounsultationPageController>().fetchData();
        break;
      case 3:
        Get.find<ProfilePageController>();
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (args != null) {
      selectedindex.value = args["indexPage"];
      fetchPageData(args["indexPage"]);
    }
  }

  void fetchPageData(int index) {
    switch (index) {
      case 0:
        Get.find<HomeController>().fetchProfile();
        break;
      case 1:
        Get.find<ArticlePageController>().fetchArticles();
        break;
      case 2:
        Get.find<CounsultationPageController>().fetchData();
        break;
      case 3:
        Get.find<ProfilePageController>();
        break;
    }
  }
}
