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
                'No journals available',
                style: h6SemiBold,
              ),
            );
          }
          return ListView.builder(
            itemCount: _controller.articleList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.ARTICLE_DETAIL);
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: whiteColor,
                  child: ListTile(
                    leading: const CircleAvatar(),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Menyusun elemen di kiri dan kanan
                      children: [
                        // Kiri: title dan subtitle
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

                        // Kanan: Text yang berada di sebelah kanan
                        Container(
                          height: 30,
                          width: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: _controller.articleList[index]["status"] == "Published" ? Colors.green 
                                    : _controller.articleList[index]["status"] == "Pending" ? Colors.orange 
                                    : Colors.red,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            _controller.articleList[index]["status"] ??
                                '', // Teks yang ingin ditampilkan di kanan
                            style: TextStyle(fontSize: 16,color: whiteColor,),
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
