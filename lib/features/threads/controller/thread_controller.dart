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
  var showThreadLoading = false.obs;
  Rx<PostModel> posts = Rx<PostModel>(PostModel());
  var showCommentLoading = false.obs;
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
  void showSingleThread(int threadId) async {
    try {
      showThreadLoading.value = true;
      final response =
          await SupabaseService.supabaseClient.from("threads").select('''
    id,content, image, created_at, comment_count, like_count, user_id, 
    user:user_id (email, metadata)
''').eq("id", threadId).single();

      showThreadLoading.value = false;

      posts.value = PostModel.fromJson(response);

      // Fetch fetchSingleComment
      fetchSingleComment(threadId);
    } catch (e) {
      showThreadLoading.value = false;
      showSnackBar("Error", "Something went wrong!");
    }
  }

  //* Show comments of single thread by id
  void fetchSingleComment(int threadId) async {
    try {
      showCommentLoading.value = true;
      final List<dynamic> response =
          await SupabaseService.supabaseClient.from("comments").select('''
  id, user_id, thread_id, reply, created_at, user:user_id(email, metadata)
''').eq("thread_id", threadId);

      showCommentLoading.value = true;

      if (response.isNotEmpty) {
        comments.value = [
          for (var item in response) CommentModel.fromJson(item)
        ];
      }
    } catch (e) {
      showCommentLoading.value = false;
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
