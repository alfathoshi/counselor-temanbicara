import 'package:counselor_temanbicara/app/services/notification_service.dart';
import 'package:counselor_temanbicara/firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await FirebaseMessaging.instance.requestPermission();
  await NotificationService.init();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    NotificationService.showNotification(message);
  });
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Teman Bicara",
      initialRoute: Routes.SPLASH_SCREEN,
      getPages: AppPages.routes,
    ),
  );
}

