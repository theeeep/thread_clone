import 'dart:io';

import 'package:get/get.dart';
import 'package:thread_clone/core/utils/helper.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);

  //* pick the image
  void pickImage() async {
    File? file = await pickImageFromGallery();
    if (file != null) image.value = file;
  }
}
