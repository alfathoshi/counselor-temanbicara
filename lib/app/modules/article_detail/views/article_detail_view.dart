import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../controllers/article_detail_controller.dart';

class ArticleDetailView extends GetView<ArticleDetailController> {
  ArticleDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final Map<String, dynamic> article = Get.arguments;
    print(article);
    final DateTime dateTime = DateTime.parse(article['created_at']);
    final String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          toolbarHeight: 85,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              side: BorderSide(color: Colors.black12)),
          title: Text(
            'Article Details',
            style: h3Bold,
          ),
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: article['image_url'] == null
                      ? Text('No Image')
                      : Image.network(
                          article['image_url'],
                          height: 221,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            article['title'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                          const Icon(Icons.share)
                        ],
                      ),
                      Row(
                        children: [
                          Text(box.read('name'),
                              style: const TextStyle(
                                  fontSize: 10, color: Color(0xFF9C9C9C))),
                          const Text(',',
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xFF9C9C9C))),
                          Text(formattedDate,
                              style: const TextStyle(
                                  fontSize: 10, color: Color(0xFF9C9C9C)))
                        ],
                      ),
                      SizedBox(
                        width: 350,
                        child: Text(
                          article['content'],
                          softWrap: true,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
