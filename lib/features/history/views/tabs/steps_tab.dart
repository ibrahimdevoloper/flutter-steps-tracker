import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/core/functions/date_formatter.dart';
import 'package:flutter_steps_tracker/features/history/controller.dart';
import 'package:get/get.dart';

class StepsTab extends StatelessWidget {
  StepsTab({Key? key}) : super(key: key);
  final HistoryController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(builder: (controller) {
      if (controller.isStepsNumberLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView.builder(
            itemCount: controller.stepsNumbers.length,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) {
              var stepsNumber = controller.stepsNumbers[index];
              return Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      "pointsAdded Points were added at step on date".trParams({
                        "pointsAdded":stepsNumber.pointsAdded.toString(),
                        "step":stepsNumber.atStep.toString(),
                        "date":dateFormater(DateTime.fromMillisecondsSinceEpoch(stepsNumber.timestamp))
                      }),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    subtitle: stepsNumber.description == null
                        ? const SizedBox(
                            width: 0,
                            height: 0,
                          )
                        : Text(
                            stepsNumber.description!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                  ),
                ),
              );
            });
      }
    });
  }
}
