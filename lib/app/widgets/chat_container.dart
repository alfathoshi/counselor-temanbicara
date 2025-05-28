import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Chatcontainer extends StatelessWidget {
  final int id;
  final String? image;
  final String? nama;
  final String? deskripsi;

  const Chatcontainer({
    super.key,
    required this.nama,
    required this.deskripsi,
    required this.image,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.CHAT_ROOM,
            arguments: {'name': nama, 'patient_id': id});
      },
      child: Container(
        width: 393,
        height: 90,
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border(
              bottom:
                  BorderSide(width: 1.5, color: Colors.grey.withOpacity(0.4))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                  ),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: greyColor,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: whiteColor,
                      child: Image.network(
                        image!,
                        scale: 5,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 13, 17, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        nama!,
                        style: h6Bold,
                      ),
                      Container(
                        width: 210,
                        child: Text(
                          deskripsi!,
                          style: h7Regular.copyWith(
                              color: Colors.grey.withOpacity(0.9)),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              "08.30",
              style: h7Regular.copyWith(color: Colors.grey.withOpacity(0.9)),
            )
          ],
        ),
      ),
    );
  }
}
