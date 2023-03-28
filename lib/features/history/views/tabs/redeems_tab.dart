import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/features/history/controller.dart';
import 'package:get/get.dart';

class RedeemsTab extends StatelessWidget {
  RedeemsTab({Key? key}) : super(key: key);
  final HistoryController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(builder: (controller) {
      if (controller.isRedeemLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView.builder(
            itemCount: controller.redeems.length,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) {
              var redeem = controller.redeems[index];
              return Card(
                child: ListTile(
                  leading: AspectRatio(
                    aspectRatio: 1,
                    child: Center(
                      child: CachedNetworkImage(
                        height: 40,
                        imageUrl: redeem.imageUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  title: Text(
                    Get.locale!.languageCode.compareTo("ar") == 0
                        ? redeem.nameAr
                        : redeem.nameEn,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  subtitle: Text(
                    "Points: redeemPoints".trParams(
                        {"redeemPoints": redeem.redeemPoints.toString()}),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              );
            });
      }
    });
  }
}
