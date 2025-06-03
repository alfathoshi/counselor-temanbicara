import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:counselor_temanbicara/app/widgets/status_chip.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticleCard extends StatelessWidget {
  final String title;
  final String content;
  final String status;
  final String createAt;
  const ArticleCard({
    super.key,
    required this.title,
    required this.content,
    required this.status,
    required this.createAt,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat("MMMM d, yyyy").format(DateTime.parse(createAt));
    return Card(
      color: whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: h4Medium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  date,
                  style: h6Regular,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            szbY8,
            Text(
              content,
              style: h6Regular,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            szbY16,
            StatusChip(
              status: status,
              icon: status == 'Published'
                  ? Icons.check_circle_outline
                  : Icons.pending_actions,
              color: status == 'Published' ? primaryColor : warning,
            )
          ],
        ),
      ),
    );
  }
}
