import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/article_detail_controller.dart';

class ArticleDetailView extends GetView<ArticleDetailController> {
  const ArticleDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned:true,
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
            'Article',
            style: h3Bold,
          ),
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/article_card.png',
                height: 221,
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Judul',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        Icon(Icons.share)
                      ],
                    ),
                    Row(
                      children: [
                        Text("Author",
                            style: TextStyle(
                                fontSize: 10, color: Color(0xFF9C9C9C))),
                        Text("27 Januari 2022",
                            style: TextStyle(
                                fontSize: 10, color: Color(0xFF9C9C9C)))
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 350,
                          child: Text(
                            'Ini deskripsi',
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                          ),
                        )
                      ],
                    ),
                   
                  ],
                ),
              ),
            ],
          ),
        ),
      
      ]),
    );
  }
}
