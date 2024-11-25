import 'package:get/get.dart';

import '../controllers/counsultation_page_controller.dart';

class CounsultationPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CounsultationPageController>(
      () => CounsultationPageController(),
    );
  }
}
