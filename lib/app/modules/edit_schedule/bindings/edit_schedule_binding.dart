import 'package:get/get.dart';

import '../controllers/edit_schedule_controller.dart';

class EditScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditScheduleController>(
      () => EditScheduleController(),
    );
  }
}
