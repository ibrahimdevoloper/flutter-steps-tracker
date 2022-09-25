import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/features/history/controller.dart';
import 'package:get/get.dart';

class StepsTab extends StatelessWidget {
  StepsTab({Key? key}) : super(key: key);
  final HistoryController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8, horizontal: 16),
              child:Text("Steps")
            ),
          );
        });
  }
}
