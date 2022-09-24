import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErrorSnakebar(String message, {title = "Error"}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    margin: EdgeInsets.zero,
    borderRadius: 0,
    duration: Duration(seconds: 3),
  );
}

void showNotificationSnakebar(message, {title = "Success"}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Color(0xFF5BB318),
    colorText: Colors.white,
    margin: EdgeInsets.zero,
    borderRadius: 0,
    duration: Duration(seconds: 3),
  );
}

void AddNewPointSnakebar() {
  Get.snackbar(
    "New Point",
    "New point were added",
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.black38,
    colorText: Colors.white,
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    borderRadius: 16,
    duration: Duration(seconds: 3),
  );
}
