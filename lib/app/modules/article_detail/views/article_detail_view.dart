import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/article_detail_controller.dart';

class ArticleDetailView extends GetView<ArticleDetailController> {
   final String? date;
  final String? title;
  final String? content;
  final String? author;
   const ArticleDetailView( {super.key,this.title, this.author, this.date, this.content,});
  
  
  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.parse(date!);
    final String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
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
               Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                         title!,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        Icon(Icons.share)
                      ],
                    ),
                    Row(
                      children: [
                        Text(author!,
                            style: TextStyle(
                                fontSize: 10, color: Color(0xFF9C9C9C))),
                                Text(',',style: TextStyle(
                                fontSize: 10, color: Color(0xFF9C9C9C))),
                        Text(formattedDate,
                            style: TextStyle(
                                fontSize: 10, color: Color(0xFF9C9C9C)))
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 350,
                          child: Text(
                            content!,
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
