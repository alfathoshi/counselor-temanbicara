import 'package:counselor_temanbicara/app/modules/article_page/views/article_page_view.dart';
import 'package:counselor_temanbicara/app/modules/counsultation_page/views/counsultation_page_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../../home/views/home_view.dart';
import '../../profile_page/views/profile_page_view.dart';
import '../controllers/navigation_bar_controller.dart';

class NavigationBarView extends GetView<NavigationBarController> {
  final List<Widget> _pages = [
     HomeView(),
    ArticlePageView(),
    CounsultationPageView(),
    ProfilePageView(),
  ];

  NavigationBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.selectedindex.value,
            children: _pages,
          )),
      bottomNavigationBar: SizedBox(
        child: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.selectedindex.value,
            onTap: (index) {
              controller.changeIndex(index);
            },
            backgroundColor: whiteColor,
            selectedItemColor: primaryColor,
            selectedLabelStyle: h6Bold,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.book), label: 'Article'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.message), label: 'Consult'),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.user),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
