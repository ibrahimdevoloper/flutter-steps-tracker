import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool?> showConfirmationDialog(String title, String content) async {
  return await Get.dialog<bool>(AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: <Widget>[
      TextButton(
        child: Text('Cancel'),
        onPressed: () {
          Get.back<bool>(result: false);
        },
      ),
      ElevatedButton(
        child: Text('Confirm'),
        onPressed: () {
          Get.back<bool>(result: true);
        },
      ),
    ],
  ));
}
