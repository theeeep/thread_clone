import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadController extends GetxController {
  final textEditingController = TextEditingController();
  var content = "".obs;
  var loading = false.obs;

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
