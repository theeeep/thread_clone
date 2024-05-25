import 'package:flutter/material.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/core/utils/helper.dart';
import 'package:thread_clone/features/profile/model/comment_model.dart';
import 'package:thread_clone/features/profile/widgets/circle_avatar_dp.dart';

class SingleThreadCommentCard extends StatelessWidget {
  final CommentModel comment;

  const SingleThreadCommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatarDp(radius: 20, url: comment.user!.metadata!.image),
            const SizedBox(width: 10),
            Text(
              comment.user!.metadata!.name!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Text(
              formatDate(comment.createdAt!),
              style: const TextStyle(color: AppPallete.greyColor),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          comment.reply!,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
