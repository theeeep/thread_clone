import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread_clone/core/services/navigation_service.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/utils/env.dart';
import 'package:thread_clone/core/utils/helper.dart';
import 'package:thread_clone/features/home/model/post_model.dart';
import 'package:thread_clone/features/profile/model/comment_model.dart';
import 'package:uuid/uuid.dart';

class ThreadController extends GetxController {
  final textEditingController = TextEditingController();
  var content = "".obs;
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);
  var fetchThreadLoading = false.obs;
  Rx<PostModel> posts = Rx<PostModel>(PostModel());
  var fetchCommentLoading = false.obs;
  RxList<CommentModel> comments = RxList<CommentModel>();

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

//* Store threads
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

  //* Show single thread by id
  void fetchSingleThread(int threadId) async {
    try {
      posts.value = PostModel();

      comments.value = [];

      fetchThreadLoading.value = true;

      final response =
          await SupabaseService.supabaseClient.from("threads").select('''
    id, content, image, created_at, comment_count, like_count, user_id, 
    user:user_id (email, metadata)
''').eq("id", threadId).single();

      fetchThreadLoading.value = false;

      posts.value = PostModel.fromJson(response);

      // Fetch fetchSingleComment
      fetchSingleComment(threadId);
    } catch (e) {
      fetchThreadLoading.value = false;
      showSnackBar("Error", "Something went wrong!");
    }
  }

  //* Show comments of single thread by id
  void fetchSingleComment(int threadId) async {
    try {
      fetchCommentLoading.value = true;

      final List<dynamic> response =
          await SupabaseService.supabaseClient.from("comments").select('''
  id, user_id, thread_id, reply, created_at, user:user_id(email, metadata)
''').eq("thread_id", threadId);

      fetchCommentLoading.value = false;

      if (response.isNotEmpty) {
        comments.value = [
          for (var item in response) CommentModel.fromJson(item)
        ];
      }

      fetchCommentLoading.value = false;
    } catch (e) {
      fetchCommentLoading.value = false;

      showSnackBar("Error", "Something went wrong!");
    }
  }

  // * Reset thread state
  void resetState() {
    content.value = "";
    textEditingController.text = "";
    image.value = null;
  }

  // * Like Dislike
  Future<void> likeDislike(
      String status, int threadId, String threadUserId, String userId) async {
    if (status == "1") {
      await SupabaseService.supabaseClient.from("likes").insert({
        "user_id": userId,
        "thread_id": threadId,
      });

      // * Add like notifications
      await SupabaseService.supabaseClient.from("notifications").insert({
        "user_id": userId,
        "notification": "Someone like your thread",
        "to_user_id": threadUserId,
        "thread_id": threadId,
      });

      // * Increment like counter
      await SupabaseService.supabaseClient
          .rpc("like_increment", params: {"count": 1, "row_id": threadId});
    } else {
      // * Delete like count in table
      await SupabaseService.supabaseClient
          .from("likes")
          .delete()
          .match({"user_id": userId, "thread_id": threadId});

      // * Decrement like counter
      await SupabaseService.supabaseClient
          .rpc("like_decrement", params: {"count": 1, "row_id": threadId});
    }
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
