import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/utils/helper.dart';
import 'package:thread_clone/features/notification/model/notification_mode.dart';

class NotificationController extends GetxController {
  var loading = false.obs;
  RxList<NottificationModel> notificationList = RxList<NottificationModel>();

  void fetchNotificatons(String userId) async {
    try {
      loading.value = true;
      final List<dynamic> response =
          await SupabaseService.supabaseClient.from("notifications").select('''
  id, thread_id, notification, created_at, user_id, user:user_id(email, metadata)
''').eq("to_user_id", userId).order("id", ascending: false);

      loading.value = false;

      if (response.isNotEmpty) {
        notificationList.value = [
          for (var item in response) NottificationModel.fromJson(item)
        ];
      }
      debugPrint("Notification response: ${jsonEncode(response)}");
    } catch (e) {
      loading.value = false;
      showSnackBar("Error", "Something went wrong!");
    }
  }
}
