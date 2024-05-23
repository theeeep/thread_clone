import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final replyEditingController = TextEditingController();
  var loading = false.obs;
  var reply = "".obs;

  @override
  void onClose() {
    replyEditingController.dispose();
    super.onClose();
  }
}
