import 'package:get/get.dart';

import '../controllers/create_article_controller.dart';

class CreateArticleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateArticleController>(
      () => CreateArticleController(),
    );
  }
}
