import 'package:get/get.dart';

import '../modules/article_detail/bindings/article_detail_binding.dart';
import '../modules/article_detail/views/article_detail_view.dart';
import '../modules/article_page/bindings/article_page_binding.dart';
import '../modules/article_page/views/article_page_view.dart';
import '../modules/available_schedule/bindings/available_schedule_binding.dart';
import '../modules/available_schedule/views/available_schedule_view.dart';
import '../modules/consultation_detail/bindings/consultation_detail_binding.dart';
import '../modules/consultation_detail/views/consultation_detail_view.dart';
import '../modules/counsultation_page/bindings/counsultation_page_binding.dart';
import '../modules/counsultation_page/views/counsultation_page_view.dart';
import '../modules/create_article/bindings/create_article_binding.dart';
import '../modules/create_article/views/create_article_view.dart';
import '../modules/edit_schedule/bindings/edit_schedule_binding.dart';
import '../modules/edit_schedule/views/edit_schedule_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/navigation_bar/bindings/navigation_bar_binding.dart';
import '../modules/navigation_bar/views/navigation_bar_view.dart';
import '../modules/profile_page/bindings/profile_page_binding.dart';
import '../modules/profile_page/views/profile_page_view.dart';
import '../modules/signin_page/bindings/signin_page_binding.dart';
import '../modules/signin_page/views/signin_page_view.dart';
import '../modules/signup_page/bindings/signup_page_binding.dart';
import '../modules/signup_page/views/signup_page_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

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
    GetPage(
      name: _Paths.CREATE_ARTICLE,
      page: () => const CreateArticleView(),
      binding: CreateArticleBinding(),
    ),
    GetPage(
      name: _Paths.ARTICLE_DETAIL,
      page: () => const ArticleDetailView(),
      binding: ArticleDetailBinding(),
    ),
    GetPage(
      name: _Paths.AVAILABLE_SCHEDULE,
      page: () => const AvailableScheduleView(),
      binding: AvailableScheduleBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_SCHEDULE,
      page: () => const EditScheduleView(),
      binding: EditScheduleBinding(),
    ),
    GetPage(
      name: _Paths.CONSULTATION_DETAIL,
      page: () => const ConsultationDetailView(),
      binding: ConsultationDetailBinding(),
    ),
  ];
}
