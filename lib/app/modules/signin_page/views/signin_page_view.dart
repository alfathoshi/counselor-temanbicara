import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/signin_page_controller.dart';

class SigninPageView extends GetView<SigninPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          side: BorderSide(color: Colors.black12),
        ),
        toolbarHeight: 85,
        backgroundColor: primaryColor,
        title: Image.asset(
          'assets/images/app_logo.png',
          color: whiteColor,
          scale: 4,
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: Text(
                        'Login',
                        style: h1Bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      onChanged: (value) {
                        controller.isEmpty();
                      },
                      controller: controller.emailC,
                      decoration: InputDecoration(
                        hintText: 'Email / Username',
                        hintStyle: const TextStyle(color: Color(0xFFc4c4c4)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFFc4c4c4))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      onChanged: (value) {
                        controller.isEmpty();
                      },
                      obscureText: controller.isSecure.value,
                      controller: controller.passC,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Color(0xFFc4c4c4)),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_red_eye),
                          onPressed: () {
                            controller.showPassword();
                          },
                        ),
                        suffixIconColor: const Color(0xFFc4c4c4),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFFc4c4c4))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 68,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.login(
                            controller.emailC.text, controller.passC.text);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.isButtonActive.value
                              ? const Color(0xFFc4c4c4)
                              : primaryColor,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(
                            double.infinity,
                            44,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        'Masuk',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
