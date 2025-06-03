import 'package:counselor_temanbicara/app/modules/article_detail/views/article_detail_view.dart';
import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
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
                  'Tidak ada artikel tersedia saat ini.',
                  style: h6Regular,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.articleList.length +
                (controller.isLoadingMore.value ? 1 : 0) +
                (!controller.hasMoreData.value &&
                        controller.articleList.isNotEmpty &&
                        !controller.isLoadingMore.value
                    ? 1
                    : 0),
            itemBuilder: (context, index) {
              if (index == controller.articleList.length &&
                  controller.isLoadingMore.value) {
                return Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                      child: CircularProgressIndicator(color: primaryColor)),
                );
              }
              if (index == controller.articleList.length &&
                  !controller.hasMoreData.value &&
                  !controller.isLoadingMore.value) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(
                    child: Text("Semua artikel sudah ditampilkan.",
                        style: h7Regular.copyWith(color: greyColor)),
                  ),
                );
              }
              if (index >= controller.articleList.length) {
                return const SizedBox.shrink();
              }
              final articleItem = controller.articleList[index];

              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.ARTICLE_DETAIL, arguments: articleItem);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    color: whiteColor,
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              articleItem["title"] ?? '',
                              style: h4Medium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          szbX8,
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: articleItem['status'] == 'Published'
                                  ? primaryColor.withValues(alpha: 0.1)
                                  : warning.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                    articleItem['status'] == 'Published'
                                        ? Icons.check_circle
                                        : Icons.pending_actions,
                                    color: articleItem['status'] == 'Published'
                                        ? primaryColor
                                        : warning,
                                    size: 24),
                                SizedBox(width: 8),
                                Text(
                                  articleItem['status'] == 'Published'
                                      ? 'Published'
                                      : 'On Review',
                                  style: TextStyle(
                                    color: articleItem['status'] == 'Published'
                                        ? primaryColor
                                        : warning,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          articleItem["content"] ?? '',
                          style: h6Regular,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
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
