import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatContainer extends StatelessWidget {
  final String id;
  final String time;
  final String? image;
  final String? nama;
  final String? deskripsi;

  const ChatContainer({
    super.key,
    required this.nama,
    required this.deskripsi,
    required this.image,
    required this.id,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.CHAT_ROOM,
            arguments: {'name': nama, 'patient_id': id, 'image': image});
      },
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border(
              bottom: BorderSide(
                  width: 1.5, color: Colors.grey.withValues(alpha: 0.4))),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(image!),
                backgroundColor: Colors.grey[200],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 13, 17, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      nama!,
                      style: h6Bold,
                    ),
                    Text(
                      deskripsi ?? '...',
                      style: h7Regular.copyWith(
                          color: Colors.grey.withValues(alpha: 0.9)),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              time,
              overflow: TextOverflow.fade,
              style:
                  h7Regular.copyWith(color: Colors.grey.withValues(alpha: 0.9)),
            )
          ],
        ),
      ),
    );
  }
}
