import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/utils/env.dart';
import 'package:thread_clone/core/utils/helper.dart';
import 'package:thread_clone/features/home/model/post_model.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  var postLoading = false.obs;
  Rx<File?> image = Rx<File?>(null);
  RxList<PostModel> posts = RxList<PostModel>();

  // * Update Profile Pic
  Future<void> updateProfile(String userId, String description) async {
    try {
      loading.value = true;
      var uploadedPath = "";
      if (image.value != null && image.value!.existsSync()) {
        final String dir = "$userId/profile.jpg";
        final String path = await SupabaseService.supabaseClient.storage
            .from(ENV.s3Bucket)
            .upload(
              dir,
              image.value!,
              fileOptions: const FileOptions(upsert: true),
            );
        uploadedPath = path;
      }

      // * Update Profile
      await SupabaseService.supabaseClient.auth.updateUser(
        UserAttributes(
          data: {
            "description": description,
            "image": uploadedPath.isNotEmpty ? uploadedPath : null
          },
        ),
      );
      loading.value = false;
      Get.back();
      showSnackBar("Success", "Profile Updated Successfully");
    } on StorageException catch (e) {
      loading.value = false;
      debugPrint("Profile Controller StorageException: ${e.message}");
      showSnackBar("Storage Error: ", e.message);
    } on AuthException catch (e) {
      loading.value = false;
      debugPrint("Profile Controller AuthException: ${e.message}");
      showSnackBar("Authentication Error", e.message);
    } catch (e) {
      loading.value = false;
      showSnackBar("Something Went Wrong", "Please Try Again!");
    }
  }

  //* pick the image
  void pickImage() async {
    File? file = await pickImageFromGallery();
    if (file != null) image.value = file;
  }

  // * Fetch Post
  void fetchUserThreads(String userId) async {
    try {
      postLoading.value = true;
      final List<dynamic> response =
          await SupabaseService.supabaseClient.from("threads").select('''
    id,content, image, created_at, comment_count, like_count, user_id, 
    user:user_id (email, metadata)
''').eq("use_id", userId).order("id", ascending: false);
      postLoading.value = false;
      debugPrint("Fetch Successfully: $response");
    } catch (e) {
      postLoading.value = false;
      showSnackBar("Error", "Fetch Threads Error");
    }
  }

  // * Fetch Replies
//   void fetchReplies(String userId) async {
//     final List<dynamic> response =
//         await SupabaseService.supabaseClient.from("comments").select('''
// ''');
//   }
}
