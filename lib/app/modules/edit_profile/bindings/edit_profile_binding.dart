import 'package:get/get.dart';

import 'package:counselor_temanbicara/app/modules/edit_profile/controllers/datepicker_controller.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(),
    );
  }
}
