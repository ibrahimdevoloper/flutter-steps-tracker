import 'package:flutter/material.dart';

class StepsTab extends StatelessWidget {
  const StepsTab({Key? key}) : super(key: key);

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
