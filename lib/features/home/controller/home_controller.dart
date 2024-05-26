import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/features/home/model/post_model.dart';

class HomeController extends GetxController {
  var loading = false.obs;
  RxList<PostModel> posts = RxList<PostModel>();

  @override
  void onInit() async {
    await fetchThreads();
    listenPostChange();
    super.onInit();
  }

  Future<void> fetchThreads() async {
    loading.value = true;
    final List<dynamic> response =
        await SupabaseService.supabaseClient.from("threads").select('''
    id,content, image, created_at, comment_count, like_count, user_id, 
    user:user_id (email, metadata), likes:likes (user_id, thread_id)
''').order("id", ascending: false);

    debugPrint("Posts are: ${jsonEncode(response)}");

    loading.value = false;

    if (response.isNotEmpty) {
      posts.value = [for (var item in response) PostModel.fromJson(item)];
    }
  }

//TODOs: Implement Realtime
  // * Listen post changes
  void listenPostChange() async {
    SupabaseService.supabaseClient
        .channel('public:threads')
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: 'threads',
            callback: (payload) {
              debugPrint('Change received: ${payload.toString()}');
            })
        .subscribe();
  }

  // * update the home feed
  // void updateFeed(PostModel post) async {
  //   var user = await SupabaseService.supabaseClient
  //       .from("users")
  //       .select("*")
  //       .eq("id", post.userId!)
  //       .single();

  // * Fetch likes
  // post.likes = [];
  // post.user = User.fromJson(user);
  // posts.insert(0, post);
  // }
}
