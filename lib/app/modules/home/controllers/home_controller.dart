import 'package:get/get.dart';

import '../../counsultation_page/controllers/counsultation_page_controller.dart';

class HomeController extends GetxController {
  var consultList = [].obs;

  final CounsultationPageController fetchConsultController =
      Get.put(CounsultationPageController());

  Future<void> fetchDataJornal() async {
    fetchConsultController.fetchData();
  }
}
