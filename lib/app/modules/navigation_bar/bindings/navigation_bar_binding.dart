import 'package:counselor_temanbicara/app/modules/article_page/controllers/article_page_controller.dart';
import 'package:counselor_temanbicara/app/modules/counsultation_page/controllers/counsultation_page_controller.dart';
import 'package:counselor_temanbicara/app/modules/home/controllers/home_controller.dart';
import 'package:counselor_temanbicara/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:get/get.dart';

import '../controllers/navigation_bar_controller.dart';

class NavigationBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationBarController>(
      () => NavigationBarController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ArticlePageController>(
      () => ArticlePageController(),
    );
    Get.lazyPut<CounsultationPageController>(
      () => CounsultationPageController(),
    );
    Get.lazyPut<ProfilePageController>(
      () => ProfilePageController(),
    );
  }
}
