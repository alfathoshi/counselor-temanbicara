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
    final ArticlePageController controller = Get.put(ArticlePageController());
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
                      color: whiteColor,
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                controller.articleList[index]["title"] ?? '',
                                style: h4Medium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            szbX8,
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: controller.articleList[index]
                                            ['status'] ==
                                        'Published'
                                    ? primaryColor.withValues(alpha: 0.1)
                                    : warning.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                      controller.articleList[index]['status'] ==
                                              'Published'
                                          ? Icons.check_circle
                                          : Icons.pending_actions,
                                      color: controller.articleList[index]
                                                  ['status'] ==
                                              'Published'
                                          ? primaryColor
                                          : warning,
                                      size: 24),
                                  SizedBox(width: 8),
                                  Text(
                                    controller.articleList[index]['status'] ==
                                            'Published'
                                        ? 'Published'
                                        : 'On Review',
                                    style: TextStyle(
                                      color: controller.articleList[index]
                                                  ['status'] ==
                                              'Published'
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
                            controller.articleList[index]["content"] ?? '',
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
