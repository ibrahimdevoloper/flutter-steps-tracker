import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/features/history/views/tabs/redeems_tab.dart';
import 'package:flutter_steps_tracker/features/history/views/tabs/steps_tab.dart';
import 'package:get/get.dart';

import '../controller.dart';

class HistoryPage extends StatelessWidget {
  final controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("History"),
          bottom: const TabBar(
            indicatorColor: Colors.yellowAccent,
            tabs: [
              Tab(text: "Vacations",),
              Tab(text: "Overtime",),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RedeemsTab(),
            StepsTab(),
          ],
        ),
      ),
    );
  }
}
