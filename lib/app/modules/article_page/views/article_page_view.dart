import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/article_page_controller.dart';

class ArticlePageView extends GetView<ArticlePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ArticlePageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ArticlePageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
