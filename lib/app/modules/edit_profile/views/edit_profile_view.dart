import 'dart:collection';

import 'package:counselor_temanbicara/app/modules/home/views/home_view.dart';
import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:counselor_temanbicara/app/widgets/custom_datepicker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          'Edit Profile',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              szbY24,
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: border,
                      child: CircleAvatar(
                        radius: 58,
                        backgroundColor: whiteColor,
                        child: Obx(() {
                          if (controller.isLoading.value) {
                            return shimmerLoader(
                              ClipOval(
                                child: Container(
                                  color: whiteColor,
                                ),
                              ),
                            );
                          } else if (controller.profile.isEmpty) {
                            return ClipOval(
                              child: Image.network(
                                  'https://qzsrrlobwlisodbasdqi.supabase.co/storage/v1/object/profile/default.png'),
                            );
                          } else {
                            return CircleAvatar(
                              radius: 58,
                              backgroundImage: NetworkImage(
                                  controller.profile['profile_url']),
                              backgroundColor: Colors.grey[200],
                            );
                          }
                        }),
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
                          Icons.camera_alt,
                          size: 16,
                          color: whiteColor,
                        ),
                        onPressed: () async {
                          await controller.pickImage();
                          if (controller.pickedImage.value != null) {
                            await controller.changeImage();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              szbY48,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama',
                    style: textDescriptionSemiBold,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: controller.nameController,
                    cursorColor: black,
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      hintStyle: h5Regular.copyWith(color: grey2Color),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: greyColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Nickname',
                    style: textDescriptionSemiBold,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: controller.nicknameController,
                    cursorColor: black,
                    decoration: InputDecoration(
                      hintText: 'Enter your nickname...',
                      hintStyle: h5Regular.copyWith(color: grey2Color),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: greyColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Email',
                    style: textDescriptionSemiBold,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    enabled: false,
                    controller: controller.emailController,
                    cursorColor: black,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Email',
                      hintStyle: h5Regular.copyWith(color: grey2Color),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: greyColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Tanggal Lahir',
                    style: textDescriptionSemiBold,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomDatePicker(initialDate: controller.selectedDate.value),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    controller.editProfile();
                    Get.offAllNamed(Routes.NAVIGATION_BAR,
                        arguments: {"indexPage": 3});
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(primaryColor),
                    foregroundColor: WidgetStatePropertyAll(whiteColor),
                  ),
                  child: const Text('Save'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
