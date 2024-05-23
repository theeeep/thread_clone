import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/utils/helper.dart';

class ThreadController extends GetxController {
  final textEditingController = TextEditingController();
  var content = "".obs;
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);

  void pickImage() async {
    File? file = await pickImageFromGallery();
    if (file != null) {
      image.value = file;
    }
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
