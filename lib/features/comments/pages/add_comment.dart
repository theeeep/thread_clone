import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/features/comments/controller/comment_controller.dart';
import 'package:thread_clone/features/home/model/post_model.dart';
import 'package:thread_clone/features/home/widgets/loading_widget.dart';
import 'package:thread_clone/features/home/widgets/post_card_image.dart';
import 'package:thread_clone/features/profile/widgets/circle_avatar_dp.dart';

class AddComment extends StatelessWidget {
  AddComment({super.key});
  final PostModel post = Get.arguments;
  final commentController = Get.put(CommentController());
  final supabaseService = Get.find<SupabaseService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close),
        ),
        actions: [
          Obx(
            () => TextButton(
              onPressed: () {
                if (commentController.reply.isNotEmpty) {
                  commentController.addReply(
                    supabaseService.currentUser.value!.id,
                    post.id!,
                    post.userId!,
                  );
                }
              },
              child: commentController.loading.value
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: LoadingWidget(),
                    )
                  : Text(
                      "Reply",
                      style: TextStyle(
                        fontWeight: commentController.reply.isNotEmpty
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: commentController.reply.isNotEmpty
                            ? AppPallete.gradient2
                            : AppPallete.greyColor,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.width * 0.12,
                  child: CircleAvatarDp(
                    url: post.user?.metadata?.image,
                    radius: 25,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: context.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.user!.metadata!.name!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(post.content!),
                      const SizedBox(height: 10),
                      if (post.image != null) PostCardImage(url: post.image!),

                      //* Reply textfield

                      TextField(
                        autofocus: true,
                        controller: commentController.replyEditingController,
                        onChanged: (value) =>
                            commentController.reply.value = value,
                        style: const TextStyle(fontSize: 14),
                        maxLines: 10,
                        minLines: 1,
                        maxLength: 1000,
                        decoration: const InputDecoration(
                          hintText: "Reply...",
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
