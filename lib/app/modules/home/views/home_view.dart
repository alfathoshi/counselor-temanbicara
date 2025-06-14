import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:counselor_temanbicara/app/widgets/client_card.dart';
import 'package:counselor_temanbicara/app/widgets/consult_date.dart';
import 'package:counselor_temanbicara/app/widgets/consultation_card.dart';
import 'package:counselor_temanbicara/app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
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

    return Scaffold(
      backgroundColor: whiteColor,
      body: RefreshIndicator(
        color: primaryColor,
        backgroundColor: whiteColor,
        onRefresh: () async {
          await Future.wait([
            controller.consult.fetchData(),
            controller.article.fetchArticles(page: 1, isInitialLoad: true),
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
                        Obx(() {
                          if (controller.consult.isLoading.value) {
                            return shimmerLoader(
                              ConsultDate(
                                eventDates: controller.consult.eventDates,
                              ),
                            );
                          } else if (controller.consult.eventDates.isEmpty) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.AVAILABLE_SCHEDULE);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    Image.asset(
                                        'assets/images/consult_card.png'),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'No upcoming',
                                            style: h3Bold.copyWith(
                                              color: whiteColor,
                                            ),
                                          ),
                                          Text(
                                            'consultations',
                                            style: h4Regular.copyWith(
                                              color: whiteColor,
                                            ),
                                          ),
                                          szbY16,
                                          Text(
                                            'Check \nSchedule',
                                            style: h4Bold.copyWith(
                                              color: whiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return ConsultDate(
                              eventDates: controller.consult.eventDates,
                            );
                          }
                        }),
                        Obx(
                          () {
                            if (controller.consult.eventDates.isNotEmpty) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 8, 8, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (controller.consult.isLoading.value)
                                          shimmerLoader(
                                            Container(
                                              color: whiteColor,
                                              child: Text(
                                                'Appointments ${controller.consult.consultList.length}',
                                                style: h4SemiBold,
                                              ),
                                            ),
                                          )
                                        else if (controller
                                            .consult.eventDates.isEmpty)
                                          Center(
                                            child: Text(
                                              'Appointments 0}',
                                              style: h4SemiBold,
                                            ),
                                          )
                                        else
                                          Text(
                                            'Appointments ${controller.consult.eventDates.length}',
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
                                  buildConsultationList(controller)
                                ],
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
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
                            return shimmerLoader(
                              SizedBox(
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
                                          Get.toNamed(
                                              Routes.CONSULTATION_DETAIL,
                                              arguments: listConsult);
                                          controller.consult.box.write(
                                              'consultation_id',
                                              listConsult['consultation_id']);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 8, 0),
                                          child: ClientCard(
                                            name: listConsult['user']
                                                ['nickname'],
                                            age: listConsult['user']
                                                ['birthdate'],
                                            gender: listConsult['user']
                                                ['gender'],
                                            note: listConsult['description'],
                                            status: listConsult['status'],
                                            profile: listConsult['user']
                                                ['profile_url'],
                                            date: listConsult['schedule']
                                                ['available_date'],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            );
                          } else if (controller.consult.consultList.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: SizedBox(
                                height: 151,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/client_card.png',
                                      scale: 4,
                                    ),
                                    szbX16,
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'No clients',
                                                  style: h4Bold.copyWith(
                                                    color: black,
                                                  ),
                                                ),
                                                Text(
                                                  'You don’t have any clients assigned yet',
                                                  style: h6Regular.copyWith(
                                                    color: black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          szbY16,
                                          MyButton(
                                            get: () {
                                              Get.offAllNamed(
                                                  Routes.NAVIGATION_BAR,
                                                  arguments: {"indexPage": 2});
                                            },
                                            color: red,
                                            text: 'Check',
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                          date: listConsult['schedule']
                                              ['available_date'],
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          }
                        }),
                        szbY8,
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                            return shimmerLoader(
                              Image.asset('assets/images/article_card.png'),
                            );
                          }
                          return GestureDetector(
                            onTap: () => Get.offAllNamed(Routes.NAVIGATION_BAR,
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
                                        '${controller.article.article['total'] ?? 0}  articles',
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

Widget buildConsultationList(HomeController controller) {
  return Obx(() {
    if (controller.consult.isLoading.value) {
      return shimmerLoader(
          buildConsultationPageView(controller.consult.consultList));
    } else if (controller.consult.consultList.isEmpty) {
      return const Center(child: Text("No Data Available"));
    } else {
      return buildConsultationPageView(controller.consult.upcomingConsult);
    }
  });
}

Widget shimmerLoader(Widget widget) {
  return Shimmer.fromColors(
    baseColor: greyColor,
    highlightColor: grey4Color,
    child: widget,
  );
}

Widget buildConsultationPageView(List<dynamic> list) {
  return SizedBox(
    height: 170,
    child: PageView.builder(
      controller: PageController(viewportFraction: 0.9),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final consult = list[index];
        return GestureDetector(
          onTap: () =>
              Get.toNamed(Routes.CONSULTATION_DETAIL, arguments: consult),
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ConsultationCard(
              name: consult['user']['nickname'],
              gender: consult['user']['gender'],
              date: consult['schedule']['available_date'],
              status: consult['status'],
              profile: consult['user']['profile_url'],
              age: consult['user']['birthdate'],
              startTime: consult['schedule']['start_time'],
              endTime: consult['schedule']['end_time'],
            ),
          ),
        );
      },
    ),
  );
}
