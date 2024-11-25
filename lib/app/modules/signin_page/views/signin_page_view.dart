import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signin_page_controller.dart';

class SigninPageView extends GetView<SigninPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SigninPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SigninPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
