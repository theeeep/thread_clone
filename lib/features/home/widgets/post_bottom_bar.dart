import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/features/home/model/post_model.dart';
import 'package:thread_clone/routes/route_names.dart';

class PostBottomBar extends StatelessWidget {
  final PostModel post;

  const PostBottomBar({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const ImageIcon(
            AssetImage("assets/icons/Heart.png"),
            size: 25,
          ),
        ),
        Text(
          "${post.likeCount}",
          style: const TextStyle(fontSize: 18),
        ),
        IconButton(
          onPressed: () {
            Get.toNamed(RouteNames.commentPage, arguments: post);
          },
          icon: const ImageIcon(
            AssetImage("assets/icons/comment.png"),
            size: 28,
          ),
        ),
        Text(
          "${post.commentCount}",
          style: const TextStyle(fontSize: 18),
        ),
        IconButton(
          onPressed: () {},
          icon: const ImageIcon(
            AssetImage("assets/icons/send.png"),
            size: 28,
          ),
        ),
      ],
    );
  }
}
