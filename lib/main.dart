import 'package:counselor_temanbicara/firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        title: "Teman Bicara",
        initialRoute: Routes.SPLASH_SCREEN,
        getPages: AppPages.routes,
      ),
    ),
    // GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: "Teman Bicara",
    //   initialRoute: Routes.SPLASH_SCREEN,
    //   getPages: AppPages.routes,
    // ),
  );
}
