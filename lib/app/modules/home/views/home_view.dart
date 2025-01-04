import 'package:counselor_temanbicara/app/modules/article_page/controllers/article_page_controller.dart';
import 'package:counselor_temanbicara/app/modules/counsultation_page/controllers/counsultation_page_controller.dart';
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
  HomeView({super.key});
  CounsultationPageController consultController =
      Get.put(CounsultationPageController());
  ArticlePageController articleController = Get.put(ArticlePageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteScheme,
      body: RefreshIndicator(
         onRefresh: () async {
          await Future.wait([
            consultController.fetchData(), 
            articleController.fetchArticles(), 
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
                                  FutureBuilder(
                                    future: consultController.fetchData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: Text(snapshot.error.toString()),
                                        );
                                      } else if (snapshot.hasData) {}
        
                                      return Text(
                                        'You have ${consultController.consultList.length} appointments',
                                        style: h4Regular,
                                      );
                                    },
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
                          szbY16,
                          Obx(() {
                            if (consultController.isLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            } else if (consultController.consultList.isEmpty) {
                              return Center(
                                child: Text("No Data Available"),
                              );
                            } else {
                              return SizedBox(
                                height: 200,
                                child: PageView.builder(
                                  controller:
                                      PageController(viewportFraction: 0.90),
                                  itemCount: consultController.consultList.length,
                                  itemBuilder: (context, index) {
                                    final listConsult =
                                        consultController.consultList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.CONSULTATION_DETAIL,
                                            arguments: listConsult);
                                        consultController.box.write(
                                            'consultation_id',
                                            listConsult['consultation_id']);
                                      },
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: ConsultationCard(
                                          name: listConsult['general_user_name'],
                                          symptoms: listConsult['description'],
                                          date: listConsult['date'],
                                          time:
                                              '${listConsult['start_time']} - ${listConsult['end_time']}',
                                          type: listConsult['problem'],
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
                          Obx(() {
                            if (consultController.isLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            } else if (consultController.consultList.isEmpty) {
                              return Center(
                                child: Text("No Data Available"),
                              );
                            } else {
                              return SizedBox(
                                height: 250,
                                child: PageView.builder(
                                  controller:
                                      PageController(viewportFraction: 0.90),
                                  itemCount: consultController.consultList.length,
                                  itemBuilder: (context, index) {
                                    final listConsult =
                                        consultController.consultList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.CONSULTATION_DETAIL,
                                            arguments: listConsult);
                                        consultController.box.write(
                                            'consultation_id',
                                            listConsult['consultation_id']);
                                      },
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: ClientCard(
                                          fullname:
                                              listConsult['general_user_name'],
                                          nickname: listConsult['nickname'],
                                          age: listConsult['birthdate'],
                                          gender: listConsult['gender'],
                                          note: listConsult['description'],
                                          status: listConsult['status'],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }),
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
                          Obx(() {
                            if (consultController.isLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            } else if (consultController.consultList.isEmpty) {
                              return Center(
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
                                            '${articleController.articleList.length} articles',
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
