import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';

void showSnackBar(String title, String message) {
  Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      snackStyle: SnackStyle.FLOATING,
      borderRadius: 10,
      duration: const Duration(seconds: 3),
      backgroundGradient: const LinearGradient(
        colors: [
          AppPallete.gradient1,
          AppPallete.gradient2,
          AppPallete.gradient3
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
      icon: const Icon(
        Icons.info_outline,
        color: Colors.white,
        size: 30,
      ),
    ),
  );
}