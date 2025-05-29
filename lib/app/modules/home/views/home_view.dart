import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:counselor_temanbicara/app/widgets/client_card.dart';
import 'package:counselor_temanbicara/app/widgets/consult_date.dart';
import 'package:counselor_temanbicara/app/widgets/consultation_card.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    controller.fetchProfile();
    controller.consult.fetchData();
    controller.article.fetchArticles();

    return Scaffold(
      backgroundColor: whiteColor,
      body: RefreshIndicator(
        color: primaryColor,
        backgroundColor: whiteColor,
        onRefresh: () async {
          await Future.wait([
            controller.consult.fetchData(),
            controller.article.fetchArticles(),
            controller.fetchProfile(),
          ]);
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              snap: true,
              floating: true,
              automaticallyImplyLeading: false,
              toolbarHeight: 85,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                side: BorderSide(
                  color: grey4Color,
                  width: 1,
                ),
              ),
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
                  child: CircleAvatar(
                    backgroundColor: primaryColor,
                    child: IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.CHAT);
                        },
                        icon: Icon(
                          Iconsax.send_1,
                          color: whiteColor,
                        )),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      color: whiteColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Upcoming Consultation',
                            style: h4SemiBold,
                          ),
                        ),
                        ConsultDate(eventDates: controller.consult.eventDates),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Appointments ${controller.consult.consultList.length}',
                                style: h4SemiBold,
                              ),
                              TextButton(
                                onPressed: () => Get.offAllNamed(
                                    Routes.NAVIGATION_BAR,
                                    arguments: {"indexPage": 2}),
                                child: Text(
                                  'See All',
                                  style: h4SemiBold.copyWith(
                                    color: primaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Obx(() {
                          if (controller.consult.isLoading.value) {
                            return Container();
                          } else if (controller.consult.consultList.isEmpty) {
                            return const Center(
                              child: Text("No Data Available"),
                            );
                          } else {
                            return SizedBox(
                              height: 170,
                              child: PageView.builder(
                                controller:
                                    PageController(viewportFraction: 0.9),
                                itemCount:
                                    controller.consult.consultList.length,
                                itemBuilder: (context, index) {
                                  final listConsult =
                                      controller.consult.consultList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.CONSULTATION_DETAIL,
                                          arguments: listConsult);
                                      controller.consult.box.write(
                                          'consultation_id',
                                          listConsult['consultation_id']);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: ConsultationCard(
                                        name: listConsult['user']['nickname'],
                                        gender: listConsult['user']['gender'],
                                        date: listConsult['schedule']
                                            ['available_date'],
                                        status: listConsult['status'],
                                        profile: listConsult['user']
                                            ['profile_url'],
                                        age: listConsult['user']['birthdate'],
                                        startTime: listConsult['schedule']
                                            ['start_time'],
                                        endTime: listConsult['schedule']
                                            ['end_time'],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            'My Client',
                            style: h4SemiBold,
                          ),
                        ),
                        szbY8,
                        Obx(() {
                          if (controller.consult.isLoading.value) {
                            return Container();
                          } else if (controller.consult.consultList.isEmpty) {
                            return const Center(
                              child: Text("No Data Available"),
                            );
                          } else {
                            return SizedBox(
                              height: 320,
                              child: PageView.builder(
                                  controller:
                                      PageController(viewportFraction: 0.85),
                                  itemCount:
                                      controller.consult.consultList.length,
                                  itemBuilder: (context, index) {
                                    final listConsult =
                                        controller.consult.consultList[index];

                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.CONSULTATION_DETAIL,
                                            arguments: listConsult);
                                        controller.consult.box.write(
                                            'consultation_id',
                                            listConsult['consultation_id']);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 8, 0),
                                        child: ClientCard(
                                          name: listConsult['user']['nickname'],
                                          age: listConsult['user']['birthdate'],
                                          gender: listConsult['user']['gender'],
                                          note: listConsult['description'],
                                          status: listConsult['status'],
                                          profile: listConsult['user']
                                              ['profile_url'],
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          }
                        }),
                        szbY16,
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Article',
                          style: h4SemiBold,
                        ),
                        szbY16,
                        Obx(() {
                          if (controller.consult.isLoading.value) {
                            return Shimmer.fromColors(
                              baseColor: greyColor,
                              highlightColor: grey4Color,
                              child:
                                  Image.asset('assets/images/article_card.png'),
                            );
                          } else if (controller.consult.consultList.isEmpty) {
                            return const Center(
                              child: Text("No Data Available"),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () => Get.offAllNamed(
                                  Routes.NAVIGATION_BAR,
                                  arguments: {"indexPage": 1}),
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Image.asset('assets/images/article_card.png'),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${controller.article.articleList.length} articles',
                                          style: h3Bold.copyWith(
                                            color: whiteColor,
                                          ),
                                        ),
                                        Text(
                                          'has been',
                                          style: h6Regular.copyWith(
                                            color: whiteColor,
                                          ),
                                        ),
                                        Text(
                                          'created',
                                          style: h6Regular.copyWith(
                                            color: whiteColor,
                                          ),
                                        ),
                                        szbY16,
                                        Text(
                                          'Create More',
                                          style: h3Bold.copyWith(
                                            color: whiteColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }),
                        szbY16,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
