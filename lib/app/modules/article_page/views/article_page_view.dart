import 'package:counselor_temanbicara/app/modules/article_detail/views/article_detail_view.dart';
import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/article_page_controller.dart';

class ArticlePageView extends GetView<ArticlePageController> {
  const ArticlePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final ArticlePageController controller = Get.put(ArticlePageController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            side: BorderSide(color: Colors.black12)),
        title: Text(
          'Article',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return controller.fetchArticles();
        },
        child: Expanded(
          child: Obx(() {
            if (controller.articleList.isEmpty) {
              return Center(
                child: Text(
                  'No articles available',
                  style: h6SemiBold,
                ),
              );
            }
            return ListView.builder(
              itemCount: controller.articleList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print(controller.articleList[index]);
                    Get.toNamed(Routes.ARTICLE_DETAIL,
                        arguments: controller.articleList[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      color: whiteColor,
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.articleList[index]["title"] ?? '',
                                  style: h4Medium,
                                ),
                                Text(
                                  controller.box.read('name') ?? '',
                                  style: h5Regular,
                                ),
                              ],
                            ),
                            Container(
                              height: 30,
                              width: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: controller.articleList[index]
                                              ["status"] ==
                                          "Published"
                                      ? Colors.green
                                      : controller.articleList[index]
                                                  ["status"] ==
                                              "Pending"
                                          ? Colors.orange
                                          : Colors.red,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                  controller.articleList[index]["status"] ?? '',
                                  style: h6Bold.copyWith(color: whiteColor)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.CREATE_ARTICLE);
        },
        shape: const CircleBorder(),
        foregroundColor: whiteColor,
        backgroundColor: primaryColor,
        child: const Icon(
          Iconsax.pen_add,
        ),
      ),
    );
  }
}
