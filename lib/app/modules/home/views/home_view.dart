import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:counselor_temanbicara/app/widgets/client_card.dart';
import 'package:counselor_temanbicara/app/widgets/consultation_card.dart';
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
                    padding: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      color: whiteColor,
                      boxShadow: const [
                        BoxShadow(
                          color: grey4Color,
                          blurRadius: 16,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 32, top: 24),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundColor: border,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: whiteColor,
                                  child: ClipOval(
                                    child: Image.network(
                                      controller.profile['profile_url'],
                                    ),
                                  ),
                                ),
                              ),
                              szbX16,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello, ${controller.profile['nickname']}',
                                    style: h3SemiBold,
                                  ),
                                  FutureBuilder(
                                    future: controller.consult.fetchData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Shimmer.fromColors(
                                          baseColor: greyColor,
                                          highlightColor: grey4Color,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: greyColor,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              'You have ${controller.consult.consultList.length} appointments',
                                              style: h4Regular,
                                            ),
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child:
                                              Text(snapshot.error.toString()),
                                        );
                                      } else if (snapshot.hasData) {}

                                      return Text(
                                        'You have ${controller.consult.consultList.length} appointments',
                                        style: h4Regular,
                                      );
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        szbY8,
                        Padding(
                          padding: const EdgeInsets.only(left: 32, right: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Appointments',
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
                            return Shimmer.fromColors(
                              baseColor: greyColor,
                              highlightColor: grey4Color,
                              child: ConsultationCard(
                                name: '',
                                gender: '',
                                date: '${DateTime.now()}',
                                status: '',
                                profile:
                                    'https://qzsrrlobwlisodbasdqi.supabase.co/storage/v1/object/profile/default.png',
                                age: '${DateTime.now()}',
                                startTime: '24:00:00',
                                endTime: '24:00:00',
                              ),
                            );
                          } else if (controller.consult.consultList.isEmpty) {
                            return const Center(
                              child: Text("No Data Available"),
                            );
                          } else {
                            return SizedBox(
                              height: 200,
                              child: PageView.builder(
                                controller:
                                    PageController(viewportFraction: 0.80),
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
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, bottom: 16),
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
                  szbY8,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: whiteColor,
                      boxShadow: const [
                        BoxShadow(
                          color: grey4Color,
                          blurRadius: 16,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 32, top: 24),
                          child: Text(
                            'My Client',
                            style: h4SemiBold,
                          ),
                        ),
                        Obx(() {
                          if (controller.consult.isLoading.value) {
                            return Shimmer.fromColors(
                              baseColor: greyColor,
                              highlightColor: grey4Color,
                              child: ClientCard(
                                fullname: '',
                                nickname: '',
                                age: '${DateTime.now()}',
                                gender: '',
                                note: '',
                                status: '',
                                profile:
                                    'https://qzsrrlobwlisodbasdqi.supabase.co/storage/v1/object/profile/default.png',
                              ),
                            );
                          } else if (controller.consult.consultList.isEmpty) {
                            return const Center(
                              child: Text("No Data Available"),
                            );
                          } else {
                            return SizedBox(
                              height: 320,
                              child: PageView.builder(
                                controller:
                                    PageController(viewportFraction: 0.80),
                                itemCount:
                                    controller.consult.consultList.length,
                                itemBuilder: (context, index) {
                                  final listConsult =
                                      controller.consult.consultList[index];
                                  if (listConsult['status'] == 'Done') {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.CONSULTATION_DETAIL,
                                            arguments: listConsult);
                                        controller.consult.box.write(
                                            'consultation_id',
                                            listConsult['consultation_id']);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0, horizontal: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: grey4Color,
                                                  blurRadius: 16,
                                                  offset: Offset(0, 2),
                                                ),
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              28),
                                                      border: Border.all(
                                                        color: whiteScheme,
                                                      ),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              28),
                                                      child: Image.network(
                                                          width:
                                                              double.infinity,
                                                          fit: BoxFit.cover,
                                                          listConsult['user']
                                                              ['profile_url']),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 16.0,
                                                      right: 16,
                                                      top: 16,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          listConsult['user']
                                                              ['nickname'],
                                                          style: h4SemiBold,
                                                        ),
                                                        Text(
                                                            '${DateTime.now().year.toInt() - 2004} / ${listConsult['user']['gender']}'),
                                                        SizedBox(
                                                          width: 200,
                                                          child: Text(
                                                            maxLines: 4,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            listConsult[
                                                                'description'],
                                                            style: h7Regular
                                                                .copyWith(
                                                                    color:
                                                                        greyColor),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16,
                                                          right: 16,
                                                          bottom: 16),
                                                  child: Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Iconsax.calendar,
                                                            size: 16,
                                                          ),
                                                          szbX4,
                                                          Text(
                                                            '27 May',
                                                            style: h6Regular,
                                                          ),
                                                        ],
                                                      ),
                                                      szbX8,
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Iconsax.clock,
                                                            size: 16,
                                                          ),
                                                          szbX4,
                                                          Text(
                                                            '10:00 pm',
                                                            style: h6Regular,
                                                          )
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    primaryColor,
                                                                border:
                                                                    Border.all(
                                                                  color: whiteColor
                                                                      .withValues(
                                                                          alpha:
                                                                              0.3),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24)),
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                16, 8, 16, 8),
                                                        child: Text(
                                                          listConsult['status'],
                                                          style: h6Bold.copyWith(
                                                              color:
                                                                  whiteColor),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      color: whiteColor,
                      boxShadow: const [
                        BoxShadow(
                          color: grey4Color,
                          blurRadius: 16,
                          offset: Offset(0, 2),
                        ),
                      ],
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
                          Obx(() {
                            if (controller.consult.isLoading.value) {
                              return Shimmer.fromColors(
                                baseColor: greyColor,
                                highlightColor: grey4Color,
                                child: Image.asset(
                                    'assets/images/article_card.png'),
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
                                    Image.asset(
                                        'assets/images/article_card.png'),
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
                              );
                            }
                          }),
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
      ),
    );
  }
}
