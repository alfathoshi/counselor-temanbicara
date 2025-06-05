import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:counselor_temanbicara/app/widgets/status_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../controllers/article_detail_controller.dart';

class ArticleDetailView extends GetView<ArticleDetailController> {
  const ArticleDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.parse(controller.args['created_at']);
    final String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.args['image_url'] != null &&
                  controller.args['image_url'].isNotEmpty)
                Center(
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(16),
                      child: Image.network(
                        controller.args['image_url'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              szbY24,
              StatusChip(
                status: controller.args['status'],
                icon: controller.args['status'] == 'Published'
                    ? Icons.check_circle_outline
                    : Icons.pending_actions,
                color: controller.args['status'] == 'Published'
                    ? primaryColor
                    : warning,
              ),
              szbY24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 300,
                    child: Text(controller.args['title'],
                        softWrap: true, maxLines: 3, style: h4Bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.box.read('name'),
                    style: h6SemiBold,
                  ),
                  Text(
                    formattedDate,
                    style: h6Regular,
                  )
                ],
              ),
              szbY16,
              SizedBox(
                width: double.infinity,
                child: Text(
                  controller.args['content'],
                  overflow: TextOverflow.fade,
                  softWrap: true,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
