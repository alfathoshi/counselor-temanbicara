import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/counsultation_page_controller.dart';

class CounsultationPageView extends GetView<CounsultationPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CounsultationPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CounsultationPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
