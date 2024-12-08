import 'package:get/get.dart';

import 'package:counselor_temanbicara/app/modules/article_page/bindings/article_page_binding.dart';
import 'package:counselor_temanbicara/app/modules/article_page/views/article_page_view.dart';
import 'package:counselor_temanbicara/app/modules/counsultation_page/bindings/counsultation_page_binding.dart';
import 'package:counselor_temanbicara/app/modules/counsultation_page/views/counsultation_page_view.dart';
import 'package:counselor_temanbicara/app/modules/home/bindings/home_binding.dart';
import 'package:counselor_temanbicara/app/modules/home/views/home_view.dart';
import 'package:counselor_temanbicara/app/modules/navigation_bar/bindings/navigation_bar_binding.dart';
import 'package:counselor_temanbicara/app/modules/navigation_bar/views/navigation_bar_view.dart';
import 'package:counselor_temanbicara/app/modules/profile_page/bindings/profile_page_binding.dart';
import 'package:counselor_temanbicara/app/modules/profile_page/views/profile_page_view.dart';
import 'package:counselor_temanbicara/app/modules/signin_page/bindings/signin_page_binding.dart';
import 'package:counselor_temanbicara/app/modules/signin_page/views/signin_page_view.dart';
import 'package:counselor_temanbicara/app/modules/signup_page/bindings/signup_page_binding.dart';
import 'package:counselor_temanbicara/app/modules/signup_page/views/signup_page_view.dart';
import 'package:counselor_temanbicara/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:counselor_temanbicara/app/modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.PROFILE_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION_BAR,
      page: () => NavigationBarView(),
      binding: NavigationBarBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.ARTICLE_PAGE,
      page: () => ArticlePageView(),
      binding: ArticlePageBinding(),
    ),
    GetPage(
      name: _Paths.COUNSULTATION_PAGE,
      page: () => CounsultationPageView(),
      binding: CounsultationPageBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN_PAGE,
      page: () => SigninPageView(),
      binding: SigninPageBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_PAGE,
      page: () => SignupPageView(),
      binding: SignupPageBinding(),
    ),
  ];
}
