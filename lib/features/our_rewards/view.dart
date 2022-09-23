import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class OurRewardsPage extends StatelessWidget {
  final controller = Get.put(OurRewardsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Rewards"),
      ),
      body: ListView.builder(itemBuilder: (context, i) {
        return Card(
          child: ListTile(
            leading: AspectRatio(
              aspectRatio: 1,
              child: Center(
                child: Text(
                  "3",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6!
                      .copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme
                        .of(context)
                        .colorScheme
                        .secondary,
                  ),
                ),
              ),
            ),
            title: Text("Reward Name"),
            subtitle: Text("Points: 100"),
          ),);
      }),
    );
  }
}
