import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/core/utils/helper.dart';
import 'package:thread_clone/features/home/model/post_model.dart';
import 'package:thread_clone/features/home/widgets/post_bottom_bar.dart';
import 'package:thread_clone/features/home/widgets/post_card_image.dart';
import 'package:thread_clone/features/home/widgets/post_top_bar.dart';
import 'package:thread_clone/features/profile/widgets/circle_avatar_dp.dart';
import 'package:thread_clone/routes/route_names.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    PostTopBar(post: post),
                    Text(
                      formatDate(post.createdAt!),
                      style: const TextStyle(color: AppPallete.greyColor),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => {
                        Get.toNamed(RouteNames.showSingleThread,
                            arguments: post.id),
                      },
                      child: Text(
                        post.content!,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (post.image != null) PostCardImage(url: post.image!),
                    PostBottomBar(post: post),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            color: Color(0xff242424),
          ),
        ],
      ),
    );
  }
}
