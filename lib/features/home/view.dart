import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/features/history/views/view.dart';
import 'package:flutter_steps_tracker/features/leaderboard/view.dart';
import 'package:flutter_steps_tracker/features/our_rewards/view.dart';
import 'package:flutter_steps_tracker/utilities/project_constants.dart';
import 'package:get/get.dart';
import 'package:odometer/odometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'controller.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text(
            "Steptiper",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              // color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          actions: [
            // IconButton(
            //     onPressed: () {
            //       Get.to(() => HistoryPage());
            //     },
            //     icon: const Icon(Icons.calendar_today_rounded))
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/icon.png",
                      height: 40,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GradientText(
                      "Steptiper",
                      style: const TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold),
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                  ],
                ),
              ),
              ToggleSwitch(
                minWidth: 90.0,
                minHeight: 34.0,
                fontSize: 16.0,
                initialLabelIndex: Get.locale!.languageCode == "ar" ? 1 : 0,
                activeBgColor: [Theme.of(context).colorScheme.primary],
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.grey[900],
                totalSwitches: 2,
                labels: ["English", "عربي"],
                onToggle: (index) {
                  print('switched to: $index');
                  var locale =
                      index == 0 ? const Locale('en') : const Locale('ar');
                  Get.updateLocale(locale);
                  SharedPreferences pref = Get.find();
                  pref.setString(
                      ProjectConstants.isArabic, locale.languageCode);
                },
              ),
              ListTile(
                title: Text(
                  "Rewards".tr,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                onTap: () {
                  Get.to(() => OurRewardsPage());
                },
              ),
              ListTile(
                title: Text(
                  "Leaderboard".tr,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                onTap: () {
                  Get.to(() => LeaderboardPage());
                },
              ),
              ListTile(
                title: Text(
                  "History".tr,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                onTap: () {
                  Get.to(() => HistoryPage());
                },
              ),
              ListTile(
                title: Text(
                  "Sign out".tr,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                onTap: () {
                  //TODO: add conformation Dialog
                  controller.signOutDialog();
                },
              ),
              ListTile(
                title: Text(
                  "Delete Account".tr,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                onTap: () {
                  //TODO: delete account
                },
              ),
              SwitchListTile(
                title: Text(
                  Get.isDarkMode ? "Dark Mode".tr : "Light Mode".tr,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                activeColor: Theme.of(context).colorScheme.primary,
                value: Get.isDarkMode,
                onChanged: (value) {
                  Get.changeThemeMode(
                      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                  SharedPreferences pref = Get.find();
                  pref.setBool(ProjectConstants.isDarkMode, Get.isDarkMode);
                },
              ),
              // SwitchListTile(
              //   title: Text(
              //     Get.locale!.languageCode.compareTo("ar") == 0
              //         ? "عربي"
              //         : "English",
              //     style: Theme.of(context).textTheme.labelLarge!.copyWith(
              //           fontWeight: FontWeight.bold,
              //           color: Theme.of(context).colorScheme.primary,
              //         ),
              //   ),
              //   activeColor: Theme.of(context).colorScheme.primary,
              //   value: Get.locale!.languageCode.compareTo("ar") == 0,
              //   onChanged: (value) {
              //     var locale = Get.locale!.languageCode.compareTo("ar") == 0
              //         ? const Locale('en')
              //         : const Locale('ar');
              //     Get.updateLocale(locale);
              //     SharedPreferences pref = Get.find();
              //     pref.setString(
              //         ProjectConstants.isArabic,
              //         Get.locale!.languageCode.compareTo("ar") == 0
              //             ? 'ar'
              //             : 'en');
              //   },
              // ),
            ],
          ),
        ),
        body: GetBuilder<HomeController>(
            init: controller,
            id: HomeController.main,
            builder: (controller) {
              if (controller.isloading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, name".trParams(
                            {"name": controller.userData?.name ?? ""}),
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                      Container(
                        height: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/yellow_icon.png',
                                          height: 20,
                                        ),
                                        Text(
                                          "Step Count".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ),
                                        ),
                                      ],
                                    ),
                                    GetBuilder<HomeController>(
                                        init: controller,
                                        id: HomeController.stepCounterTag,
                                        builder: (controller) {
                                          return AnimatedSlideOdometerNumber(
                                            letterWidth: 36,
                                            odometerNumber:
                                                OdometerNumber.fromDigits({
                                              1: (controller.stepCount % 10)
                                                  .floorToDouble(),
                                              2: (controller.stepCount /
                                                      10 %
                                                      10)
                                                  .floorToDouble(),
                                              3: (controller.stepCount /
                                                      100 %
                                                      10)
                                                  .floorToDouble(),
                                              4: (controller.stepCount /
                                                      1000 %
                                                      10)
                                                  .floorToDouble(),
                                            }),
                                            duration: const Duration(
                                                milliseconds: 600),
                                            numberTextStyle: Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      Text(
                                        "HP Count".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                      ),
                                    ],
                                  ),
                                  GetBuilder<HomeController>(
                                      init: controller,
                                      id: HomeController.heathPointsTag,
                                      builder: (controller) {
                                        return AnimatedSlideOdometerNumber(
                                          letterWidth: 36,
                                          odometerNumber:
                                              OdometerNumber.fromDigits({
                                            1: (controller.healthPoints % 10)
                                                .floorToDouble(),
                                            2: (controller.healthPoints /
                                                    10 %
                                                    10)
                                                .floorToDouble(),
                                            3: (controller.healthPoints /
                                                    100 %
                                                    10)
                                                .floorToDouble(),
                                            4: (controller.healthPoints /
                                                    1000 %
                                                    10)
                                                .floorToDouble(),
                                          }),
                                          duration: const Duration(seconds: 1),
                                          numberTextStyle: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          "20 Steps = 1 Heath Point (HP)".tr,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.7),
                                  ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top 3".tr,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => LeaderboardPage());
                            },
                            child: Text(
                              "See more".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 6,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.users.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  controller.users[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                                subtitle: Text(
                                  "Step Count: stepCount".trParams({
                                    "stepCount": controller
                                        .users[index].stepCount
                                        .toString(),
                                  }),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.7),
                                      ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Redeem Rewards".tr,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => OurRewardsPage());
                            },
                            child: Text(
                              "See more".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 3,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.rewards.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            var reward = controller.rewards[i];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.defaultDialog(
                                    radius: 16,
                                    title: "Redeem from brand"
                                        .trParams({"brand": reward.brand}),
                                    content: Text(
                                        "Do you want to redeem redeemPoints for name?"
                                            .trParams({
                                          "redeemPoints":
                                          reward.redeemPoints.toString(),
                                          "name": Get.locale!.languageCode
                                              .compareTo("ar") ==
                                              0
                                              ? reward.nameAr
                                              : reward.nameEn
                                        })),
                                    textConfirm: "Redeem".tr,
                                    confirmTextColor:
                                    Theme.of(context).colorScheme.primary,
                                    textCancel: "Cancel".tr,
                                    cancelTextColor:
                                    Theme.of(context).colorScheme.primary,
                                    onConfirm: () {
                                      controller.redeemPoints(reward);
                                      Get.back();
                                    },
                                  );
                                },
                                child: AspectRatio(
                                  aspectRatio: 0.7,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        CachedNetworkImage(
                                          height: 40,
                                          imageUrl: reward.imageUrl,
                                          placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                        ),
                                        Text(
                                          Get.locale!.languageCode
                                              .compareTo("ar") ==
                                              0
                                              ? reward.nameAr
                                              : reward.nameEn,
                                          overflow: TextOverflow.fade,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}
