import 'package:counselor_temanbicara/app/modules/article_detail/views/article_detail_view.dart';
import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:counselor_temanbicara/app/widgets/article_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/article_page_controller.dart';

class ArticlePageView extends GetView<ArticlePageController> {
  const ArticlePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteScheme,
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
        onRefresh: controller.refreshArticles,
        color: primaryColor,
        child: Obx(() {
          if (controller.isLoadingInitial.value &&
              controller.articleList.isEmpty) {
            return Center(
                child: CircularProgressIndicator(color: primaryColor));
          }

          if (controller.articleList.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  'No articles yet',
                  style: h6Regular,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView(
            controller: controller.scrollController,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Text(
                  'You have created ${controller.article['total']} articles',
                  style: h5SemiBold,
                ),
              ),
              ...List.generate(
                controller.articleList.length,
                (index) {
                  final articleItem = controller.articleList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.ARTICLE_DETAIL,
                          arguments: articleItem);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ArticleCard(
                        title: articleItem['title'],
                        content: articleItem['content'],
                        status: articleItem['status'],
                        createAt: articleItem['created_at'],
                      ),
                    ),
                  );
                },
              ),
              if (controller.isLoadingMore.value)
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  ),
                ),
              if (!controller.hasMoreData.value &&
                  controller.articleList.isNotEmpty &&
                  !controller.isLoadingMore.value)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(
                    child: Text(
                      "All articles are displayed",
                      style: h7Regular.copyWith(color: greyColor),
                    ),
                  ),
                ),
            ],
          );
        }),
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
