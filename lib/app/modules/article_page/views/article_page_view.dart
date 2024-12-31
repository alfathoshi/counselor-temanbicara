import 'package:counselor_temanbicara/app/modules/article_detail/views/article_detail_view.dart';
import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/article_page_controller.dart';

class ArticlePageView extends GetView<ArticlePageController> {
  ArticlePageView({super.key});
  final ArticlePageController _controller = Get.put(ArticlePageController());

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
      body: Expanded(
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
            itemCount: _controller.articleList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => ArticleDetailView(
                        title: _controller.articleList[index]["title"],
                        author:  _controller.box.read('name'),
                        date:  _controller.articleList[index]["created_at"],
                        content:
                            _controller.articleList[index]["content"],
                      ));
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: whiteColor,
                  child: ListTile(
                    leading:  CircleAvatar(
                      radius: 17,
                      backgroundColor: grey2Color,
                      child: CircleAvatar(
                          radius: 16,
                          backgroundColor: whiteColor,
                          child: Image.asset('assets/images/profile_picture.png', scale:8,),
                        ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _controller.articleList[index]["title"] ?? '',
                              style: h4Medium,
                            ),
                            Text(
                              _controller.box.read('name') ?? '',
                              style: h5Regular,
                            ),
                          ],
                        ),
                      
                        Container(
                          height: 30,
                          width: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: _controller.articleList[index]["status"] ==
                                      "Published"
                                  ? Colors.green
                                  : _controller.articleList[index]["status"] ==
                                          "Pending"
                                      ? Colors.orange
                                      : Colors.red,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            _controller.articleList[index]["status"] ?? '',
                            style: h6Bold.copyWith(color: whiteColor)
                          ),
                        ),
                      ],
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
