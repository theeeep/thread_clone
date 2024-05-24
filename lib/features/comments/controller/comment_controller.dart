import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/utils/helper.dart';

class CommentController extends GetxController {
  final replyEditingController = TextEditingController();
  var loading = false.obs;
  var reply = "".obs;

  void addReply(String userId, int threadId, String threadUserId) async {
    try {
      loading.value = false;

      //* increase the post comment count
      await SupabaseService.supabaseClient
          .rpc("comment_increment", params: {"count": 1, "row_id": threadId});

      //* Add Notificatoin
      await SupabaseService.supabaseClient.from("notifications").insert({
        "user_id": userId,
        "notification": "Someone Comment on your thread",
        "to_user_id": threadUserId,
        "thread_id": threadId,
      });

      //* store comment to comment table DB
      await SupabaseService.supabaseClient.from("comments").insert({
        "thread_id": threadId,
        "user_id": userId,
        "reply": replyEditingController.text,
      });

      loading.value = false;
      showSnackBar("Reply Done", "You reply to thread");
    } catch (e) {
      loading.value = false;
      showSnackBar("Error", "Something went wrong!");
    }
  }

  @override
  void onClose() {
    replyEditingController.dispose();
    super.onClose();
  }
}
