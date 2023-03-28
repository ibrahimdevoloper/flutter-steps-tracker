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
    duration: const Duration(seconds: 3),
  );
}

void showNotificationSnakebar(message, {title = "Success"}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: const Color(0xFF5BB318),
    colorText: Colors.white,
    margin: EdgeInsets.zero,
    borderRadius: 0,
    duration: const Duration(seconds: 3),
  );
}