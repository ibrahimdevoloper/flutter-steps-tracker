import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/features/history/views/view.dart';
import 'package:flutter_steps_tracker/features/leaderboard/view.dart';
import 'package:flutter_steps_tracker/features/our_rewards/view.dart';
import 'package:get/get.dart';
import 'package:odometer/odometer.dart';

import 'controller.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());

  var _count = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Steptiper",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              // color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => HistoryPage());
                },
                icon: Icon(Icons.calendar_today_rounded))
          ],
        ),
        //TODO: put drawer
        body: GetBuilder<HomeController>(
            init: controller,
            id: HomeController.main,
            builder: (controller) {
              if (controller.isloading) {
                return Center(
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
                        "Hi, ${controller.userData.name}",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      Container(
                        height: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.60),
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
                                          "Step Count",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                    .withOpacity(0.90),
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
                                                .headline2!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                      .withOpacity(0.90),
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
                                        "HP Count",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
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
                                              .headline2!
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
                          "20 Steps = 1 Heath Point (HP)",
                          style: Theme.of(context).textTheme.caption!.copyWith(
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
                            "Top 3",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
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
                              "See more",
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: ListTile(
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: Center(
                              child: Text(
                                "1",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
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
                            controller.users[0].name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          subtitle: Text(
                            "Step Count: ${controller.users[0].stepCount}",
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.7),
                                    ),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: ListTile(
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: Center(
                              child: Text(
                                "2",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
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
                            controller.users[1].name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          subtitle: Text(
                            "Step Count: ${controller.users[1].stepCount}",
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.7),
                                    ),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: ListTile(
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: Center(
                              child: Text(
                                "3",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
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
                            controller.users[2].name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          subtitle: Text(
                            "Step Count: ${controller.users[2].stepCount}",
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.7),
                                    ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Redeem Rewards",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
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
                              "See more",
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
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
                        flex: 2,
                        child: ListView.builder(
                          itemCount: controller.rewards.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            var reward = controller.rewards[i];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: InkWell(
                                onTap: (){
                                  Get.defaultDialog(
                                    radius: 16,
                                    title: "Redeem from ${reward.brand}",
                                    content: Text("Do you want to redeem ${reward.redeemPoints} for ${reward.nameEn}?"),
                                    textConfirm: "Redeem",
                                    confirmTextColor: Theme.of(context).colorScheme.primary,
                                    textCancel: "Cancel",
                                      cancelTextColor: Theme.of(context).colorScheme.primary,
                                    onConfirm: (){
                                      //TODO: Redeem points
                                      Get.back();
                                    },
                                    onCancel: (){
                                      Get.back();
                                    }
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
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                        Text(
                                          reward.nameEn,
                                          overflow: TextOverflow.fade,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
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
