import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/features/history/controller.dart';
import 'package:get/get.dart';

class RedeemsTab extends StatelessWidget {
  RedeemsTab({Key? key}) : super(key: key);
  final HistoryController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: AspectRatio(
                aspectRatio: 1,
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
              title: Text("Reward Name"),
              subtitle: Text("Points: 100"),
            ),
          );
        });
  }
}
