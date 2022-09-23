import 'package:flutter/material.dart';
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
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, username",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.60),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/icon.png',
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
                            AnimatedSlideOdometerNumber(
                              letterWidth: 36,
                              odometerNumber: OdometerNumber.fromDigits({
                                1: (_count % 10).floorToDouble(),
                                2: (_count / 10 % 10).floorToDouble(),
                                3: (_count / 100 % 10).floorToDouble(),
                              }),
                              duration: const Duration(seconds: 1),
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
                            ),
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
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              Text(
                                "HP Count",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ],
                          ),
                          AnimatedSlideOdometerNumber(
                            letterWidth: 36,
                            odometerNumber: OdometerNumber.fromDigits({
                              1: (_count % 10).floorToDouble(),
                              2: (_count / 10 % 10).floorToDouble(),
                              3: (_count / 100 % 10).floorToDouble(),
                            }),
                            duration: const Duration(seconds: 1),
                            numberTextStyle: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  "100 Steps = 1 Heath Point (HP)",
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
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      //TODO: GO TO Leader Board
                    },
                    child: Text(
                      "See more",
                      style: Theme.of(context).textTheme.button!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
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
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                  ),
                  title: Text(
                    "Naiem",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  subtitle: Text(
                    "7000",
                    style: Theme.of(context).textTheme.caption!.copyWith(
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
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                  ),
                  title: Text(
                    "Naiem",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  subtitle: Text(
                    "7000",
                    style: Theme.of(context).textTheme.caption!.copyWith(
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
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                  ),
                  title: Text(
                    "Naiem",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  subtitle: Text(
                    "7000",
                    style: Theme.of(context).textTheme.caption!.copyWith(
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
                    "Redeem Rewards",style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      //TODO: GO TO Leader Board
                    },
                    child: Text(
                      "See more",
                      style: Theme.of(context).textTheme.button!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: AspectRatio(
                          aspectRatio: 1,
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
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
