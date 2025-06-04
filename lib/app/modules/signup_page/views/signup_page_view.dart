import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signup_page_controller.dart';

class SignupPageView extends GetView<SignupPageController> {
  const SignupPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignupPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SignupPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
