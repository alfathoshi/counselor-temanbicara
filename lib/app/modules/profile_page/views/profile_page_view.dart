// ignore_for_file: prefer_const_constructors

import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
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
          'Profile',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(32, 24, 32, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: border,
                        child: ClipOval(
                          child: CircleAvatar(
                            radius: 58,
                            backgroundColor: whiteColor,
                            child: Image.network(
                              controller.profile['profile_url'],
                              scale: 2,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 16,
                            color: whiteColor,
                          ),
                          onPressed: () {
                            print(box.read('token'));
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    box.read('name'),
                    style: h3Bold,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 48,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account Settings',
                  style: h4Regular,
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.EDIT_PROFILE);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit Profile',
                        style: h4SemiBold,
                      ),
                      Icon(
                        Icons.chevron_right_outlined,
                        size: 32,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.CHANGE_PASSWORD);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Change Password',
                        style: h4SemiBold,
                      ),
                      Icon(
                        Icons.chevron_right_outlined,
                        size: 32,
                      )
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 16,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Change Language',
                //       style: h4SemiBold,
                //     ),
                //     Icon(
                //       Icons.chevron_right_outlined,
                //       size: 32,
                //     )
                //   ],
                // ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.AVAILABLE_SCHEDULE);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Available Schedule',
                        style: h4SemiBold,
                      ),
                      Icon(
                        Icons.chevron_right_outlined,
                        size: 32,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Divider(),

                // SizedBox(
                //   height: 16,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Privacy Policy',
                //       style: h4SemiBold,
                //     ),
                //     Icon(
                //       Icons.chevron_right_outlined,
                //       size: 32,
                //     )
                //   ],
                // ),
              ],
            ),
            szbY24,
            GestureDetector(
              onTap: () {
                Get.offAllNamed(
                  Routes.SIGNIN_PAGE,
                );
                final box = GetStorage();
                box.erase();
              },
              child: Text(
                'Logout',
                style: h4SemiBold.copyWith(color: error),
              ),
            )
          ],
        ),
      ),
    );
  }
}
