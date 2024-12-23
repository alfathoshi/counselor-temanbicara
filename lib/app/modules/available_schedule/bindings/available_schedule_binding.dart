import 'package:get/get.dart';

import '../controllers/available_schedule_controller.dart';

class AvailableScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AvailableScheduleController>(
      () => AvailableScheduleController(),
    );
  }
}
