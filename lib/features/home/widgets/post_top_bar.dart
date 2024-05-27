import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/features/home/model/post_model.dart';
import 'package:thread_clone/routes/route_names.dart';

class PostTopBar extends StatelessWidget {
  final PostModel post;
  final supabaseService = Get.find<SupabaseService>();

  PostTopBar({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          //TODO: Implement this
          onTap: () {
            if (post.userId == supabaseService.currentUser.value!.id) {
              Get.toNamed(RouteNames.showProfile);
            } else {
              Get.toNamed(RouteNames.showUser, arguments: post.userId);
            }
          },
          // onTap: () => Get.toNamed(RouteNames.showUser, arguments: post.userId),

          child: Text(
            post.user!.metadata!.name!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const Row(
          children: [Icon(Icons.more_horiz)],
        ),
      ],
    );
  }
}
