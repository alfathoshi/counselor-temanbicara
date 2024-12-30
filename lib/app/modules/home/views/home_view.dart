import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:counselor_temanbicara/app/widgets/client_card.dart';
import 'package:counselor_temanbicara/app/widgets/consultation_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteScheme,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 85,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                side: BorderSide(color: Colors.black12)),
            title: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/app_logo.png',
                    scale: 5,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Teman',
                        style: h4Bold.copyWith(color: primaryColor),
                      ),
                      Text(
                        'Bicara',
                        style: h4Bold.copyWith(color: primaryColor),
                      ),
                    ],
                  )
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.CHAT);
                    },
                    icon: Icon(
                      Iconsax.send_1,
                      color: primaryColor,
                    )),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: whiteColor,
                      border: BorderDirectional(
                          bottom: BorderSide(
                        color: border,
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 21, 32, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: border,
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: whiteColor,
                                child: Image.asset(
                                  'assets/images/profile_picture.png',
                                  scale: 4,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 21,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello, User',
                                  style: h3SemiBold,
                                ),
                                Text(
                                  'You have 3 appointments',
                                  style: h4Regular,
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Appointments',
                              style: h4SemiBold,
                            ),
                            Text(
                              'See All',
                              style: h4SemiBold.copyWith(
                                color: primaryColor,
                              ),
                            )
                          ],
                        ),
                        szbY16,
                        SizedBox(
                          height: 200,
                          child: PageView.builder(
                            controller: PageController(viewportFraction: 0.90),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: ConsultationCard(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                szbY8,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: whiteColor,
                    border: Border.all(color: border),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 21, 32, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Client',
                          style: h4SemiBold,
                        ),
                        szbY16,
                        SizedBox(
                          height: 250,
                          child: PageView.builder(
                            controller: PageController(viewportFraction: 0.90),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: ClientCard(),
                              );
                            },
                          ),
                        ),
                        szbY16,
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: whiteColor,
                    border: Border.all(color: border),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 21, 32, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Article',
                          style: h4SemiBold,
                        ),
                        szbY16,
                        GestureDetector(
                          onTap: () => Get.offAllNamed(Routes.NAVIGATION_BAR,
                              arguments: {"indexPage": 1}),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Image.asset('assets/images/article_card.png'),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '300 Views',
                                      style: h3Bold.copyWith(
                                        color: whiteColor,
                                      ),
                                    ),
                                    Text(
                                      '100 Likes',
                                      style: h3Bold.copyWith(
                                        color: whiteColor,
                                      ),
                                    ),
                                    Text(
                                      'on your articles',
                                      style: h6Regular.copyWith(
                                        color: whiteColor,
                                      ),
                                    ),
                                    szbY16,
                                    Row(
                                      children: [
                                        Text(
                                          'Create More',
                                          style: h3Bold.copyWith(
                                            color: whiteColor,
                                          ),
                                        ),
                                        szbX16,
                                        Icon(
                                          Icons.arrow_circle_right,
                                          color: whiteColor,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        szbY16,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
