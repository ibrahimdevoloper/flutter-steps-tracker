import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class OurRewardsPage extends StatelessWidget {
  final controller = Get.put(OurRewardsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Our Rewards"),
      ),
      body: GetBuilder<OurRewardsController>(
          init: controller,
          builder: (controller) {
            if (controller.isloading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: controller.rewards.length,
                  itemBuilder: (context, i) {
                    var reward = controller.rewards[i];
                    return Card(
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
                                controller.redeemPoints(reward);
                                Get.back();
                              },
                              onCancel: (){
                                Get.back();
                              }
                          );
                        },
                        child: ListTile(
                          leading: AspectRatio(
                            aspectRatio: 1,
                            child: Center(
                              child: CachedNetworkImage(
                                height: 40,
                                imageUrl: reward.imageUrl,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                          title: Text(
                            reward.nameEn,
                            style: Theme.of(context).textTheme.button!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          subtitle: Text(
                            "Points: ${reward.redeemPoints}",
                            style: Theme.of(context).textTheme.caption!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
