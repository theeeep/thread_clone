import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread_clone/core/services/navigation_service.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/utils/env.dart';
import 'package:thread_clone/core/utils/helper.dart';
import 'package:uuid/uuid.dart';

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
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void storeThreads(String userID) async {
    try {
      loading.value = true;
      const uuid = Uuid();
      final dir = "$userID/${uuid.v6()}";
      var imgPath = "";

      if (image.value != null && image.value!.existsSync()) {
        imgPath = await SupabaseService.supabaseClient.storage
            .from(ENV.s3Bucket)
            .upload(dir, image.value!);
      }

      // * Add Threads to DB
      await SupabaseService.supabaseClient.from("threads").insert({
        "user_id": userID,
        "content": content.value,
        "image": imgPath.isNotEmpty ? imgPath : null
      });

      loading.value = false;
      resetState();
      Get.find<NavigationService>().currentIndex.value = 0;
      showSnackBar("Success", "Thread Uploaded");
    } on StorageException catch (e) {
      loading.value = false;
      debugPrint("Thread Controller AuthException: ${e.message}");
      showSnackBar("Storage Error", e.message);
    } catch (e) {
      loading.value = false;
      debugPrint("Thread Controller AuthException: Something Went Wrong");
      showSnackBar("Error", "Something Went Wrong!");
    }
  }

  // * Reset thread state
  void resetState() {
    content.value = "";
    textEditingController.text = "";
    image.value = null;
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
