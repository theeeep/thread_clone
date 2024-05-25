import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/features/profile/model/comment_model.dart';
import 'package:thread_clone/features/profile/widgets/circle_avatar_dp.dart';
import 'package:thread_clone/features/profile/widgets/comment_card_top_bar.dart';

class ProfileCommentCard extends StatelessWidget {
  final CommentModel comment;
  const ProfileCommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: CircleAvatarDp(
                radius: 20,
                url: comment.user?.metadata?.image,
              ),
            ),
            const SizedBox(width: 10),
            CommentCardTopBar(comment: comment),
          ],
        ),
        const Divider(
          color: Color(0xff242424),
        ),
      ],
    );
  }
}
