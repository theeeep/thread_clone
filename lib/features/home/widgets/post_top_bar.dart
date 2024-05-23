import 'package:flutter/material.dart';
import 'package:thread_clone/features/home/model/post_model.dart';

class PostTopBar extends StatelessWidget {
  final PostModel post;

  const PostTopBar({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          post.user!.metadata!.name!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Row(
          children: [Icon(Icons.more_horiz)],
        ),
      ],
    );
  }
}
