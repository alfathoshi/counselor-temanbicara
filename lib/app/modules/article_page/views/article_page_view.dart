import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
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
        onRefresh: controller.refreshArticles,
        color: primaryColor,
        backgroundColor: whiteColor,
        child: Obx(() {
          final isLoading = controller.isLoadingInitial.value;
          final articleList = controller.articleList;
          final isLoadingMore = controller.isLoadingMore.value;
          final hasMore = controller.hasMoreData.value;
          final totalArticles = controller.article['total'];

          return articleList.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    if (isLoading)
                     Container()
                    else
                      const Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Center(
                          child: Text(
                            'No articles yet',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                )
              : ListView(
                  controller: controller.scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                      child: Text(
                        'You have created $totalArticles articles',
                        style: h5SemiBold,
                      ),
                    ),
                    ...List.generate(articleList.length, (index) {
                      final articleItem = articleList[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            Routes.ARTICLE_DETAIL,
                            arguments: articleItem,
                          );
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
                    }),
                    if (isLoadingMore)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    if (!hasMore && articleList.isNotEmpty && !isLoadingMore)
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
    );
  }
}
