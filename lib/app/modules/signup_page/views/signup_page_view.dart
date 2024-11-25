import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signup_page_controller.dart';

class SignupPageView extends GetView<SignupPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignupPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SignupPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
