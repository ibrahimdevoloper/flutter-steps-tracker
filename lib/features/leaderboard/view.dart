import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class LeaderboardPage extends StatelessWidget {
  final controller = Get.put(LeaderboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Leaderboard"),
      ),
      body: GetBuilder<LeaderboardController>(
          init:controller,
          builder: (controller) {
            if(controller.isloading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
          itemCount: controller.users.length,
            itemBuilder: (context, i) {
            var user = controller.users[i];
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
                  color: i % 2 == 0 ? Theme
                      .of(context)
                      .colorScheme
                      .primary : Theme
                      .of(context)
                      .colorScheme
                      .secondary,
                ),
                child: Center(
                  child: Text(
                    (i+1).toString(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6!
                        .copyWith(
                      fontWeight: FontWeight.bold,
                      color: i % 2 == 0 ? Theme
                          .of(context)
                          .colorScheme
                          .secondary : Theme
                          .of(context)
                          .colorScheme
                          .primary,
                    ),
                  ),
                ),
              ),
              title: Text(
                user.name,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                ),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total steps: ${user.stepCount}",
                    style: Theme
                        .of(context)
                        .textTheme
                        .caption!
                        .copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),
                    ),
                  ), Text(
                    "Redeemed points: ${user.redeemedPoints}",
                    style: Theme
                        .of(context)
                        .textTheme
                        .caption!
                        .copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
            }
      }),
    );
  }
}
