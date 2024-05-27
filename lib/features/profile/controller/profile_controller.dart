import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/utils/env.dart';
import 'package:thread_clone/core/utils/helper.dart';
import 'package:thread_clone/features/home/model/post_model.dart';
import 'package:thread_clone/features/home/model/user_model.dart';
import 'package:thread_clone/features/profile/model/comment_model.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  var postLoading = false.obs;
  var userLoading = false.obs;
  var deleteLoading = false.obs;
  var commentLoading = false.obs;
  Rx<File?> image = Rx<File?>(null);
  RxList<PostModel> posts = RxList<PostModel>();
  RxList<CommentModel> comments = RxList<CommentModel>();
  Rx<UserModel> user = Rx<UserModel>(UserModel());

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

  // * Fetch User
  void fetchUserProfile(String userId) async {
    try {
      userLoading.value = true;

      final response = await SupabaseService.supabaseClient
          .from("users")
          .select("*")
          .eq("id", userId)
          .single();

      userLoading.value = false;
      debugPrint("Fetch user threads Successfully: ${jsonEncode(response)}");
      user.value = UserModel.fromJson(response);

      // * Fetch user threads and replies
      fetchUserThreads(userId);
      fetchReplies(userId);
    } catch (e) {
      userLoading.value = false;
      showSnackBar("Something Went Wrong", "Please Try Again!");
    }
  }

  // * Fetch Post
  void fetchUserThreads(String userId) async {
    try {
      postLoading.value = true;
      final List<dynamic> response =
          await SupabaseService.supabaseClient.from("threads").select('''
    id,content, image, created_at, comment_count, like_count, user_id, 
    user:user_id (email, metadata), likes:likes (user_id, thread_id)
''').eq("user_id", userId).order("id", ascending: false);
      postLoading.value = false;

      debugPrint("Fetch threads Successfully: ${jsonEncode(response)}");

      if (response.isNotEmpty) {
        posts.value = [for (var item in response) PostModel.fromJson(item)];
      }
    } catch (e) {
      postLoading.value = false;
      showSnackBar("Error", "Something went wrong!");
    }
  }

  // * Fetch Replies
  void fetchReplies(String userId) async {
    try {
      commentLoading.value = true;
      final List<dynamic> response =
          await SupabaseService.supabaseClient.from("comments").select('''
  id, user_id, thread_id, reply, created_at, user:user_id(email, metadata)
''').eq("user_id", userId).order("id", ascending: false);
      commentLoading.value = false;

      debugPrint("Fetch Comments Successfully: ${jsonEncode(response)}");

      if (response.isNotEmpty) {
        comments.value = [
          for (var item in response) CommentModel.fromJson(item)
        ];
      }
    } catch (e) {
      commentLoading.value = false;
      showSnackBar("Error", "Something went wrong!");
    }
  }

  // * Delete Thread
  Future<void> deleteThread(int threadId) async {
    try {
      deleteLoading.value = true;
      await SupabaseService.supabaseClient
          .from("threads")
          .delete()
          .eq("id", threadId);

      deleteLoading.value = true;
      posts.removeWhere((element) => element.id == threadId);
      if (Get.isDialogOpen == true) Get.back();

      showSnackBar("Success", "Thread Deleted!");
    } catch (e) {
      deleteLoading.value = false;
      showSnackBar("Error", "Something went wrong!");
    }
  }

  // * Delete Comments
  Future<void> deleteComments(int commentId) async {
    try {
      commentLoading.value = true;
      await SupabaseService.supabaseClient
          .from("comments")
          .delete()
          .eq("id", commentId);

      commentLoading.value = true;
      comments.removeWhere((element) => element.id == commentId);
      if (Get.isDialogOpen == true) Get.back();
    } catch (e) {
      commentLoading.value = false;
      showSnackBar("Error", "Something went wrong!");
    }
  }
}
