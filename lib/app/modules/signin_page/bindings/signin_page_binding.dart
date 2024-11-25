import 'package:get/get.dart';

import '../controllers/signin_page_controller.dart';

class SigninPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SigninPageController>(
      () => SigninPageController(),
    );
  }
}
