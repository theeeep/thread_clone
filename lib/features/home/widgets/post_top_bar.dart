import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/core/utils/helper.dart';
import 'package:thread_clone/core/utils/type_def.dart';
import 'package:thread_clone/features/home/model/post_model.dart';
import 'package:thread_clone/routes/route_names.dart';

class PostTopBar extends StatelessWidget {
  final PostModel post;
  final bool isAuthCard;
  final DeleteCallback? callback;
  final supabaseService = Get.find<SupabaseService>();

  PostTopBar({
    super.key,
    required this.post,
    this.isAuthCard = false,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            if (post.userId == supabaseService.currentUser.value!.id) {
              Get.toNamed(RouteNames.showProfile);
            } else {
              Get.toNamed(RouteNames.showUser, arguments: post.userId);
            }
          },
          child: Text(
            post.user!.metadata!.name!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            isAuthCard
                ? GestureDetector(
                    onTap: () {
                      confirmDialog("Delete Thread", "Are you sure", () {
                        callback!(post.id!);
                      });
                    },
                    child: const Icon(
                      Icons.delete_outline_rounded,
                      color: AppPallete.errorColor,
                    ),
                  )
                : const Icon(Icons.more_horiz),
          ],
        ),
      ],
    );
  }
}
