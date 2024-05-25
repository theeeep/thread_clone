import 'package:flutter/material.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/core/utils/helper.dart';
import 'package:thread_clone/features/home/model/user_model.dart';
import 'package:thread_clone/features/profile/widgets/btn_style.dart';
import 'package:thread_clone/features/profile/widgets/circle_avatar_dp.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: CircleAvatarDp(
          radius: 25,
          url: user.metadata?.image,
        ),
      ),
      title: Text(user.metadata!.name!),
      titleAlignment: ListTileTitleAlignment.top,
      trailing: OutlinedButton(
        onPressed: () {},
        style: customOutlineBtnStyle(),
        child: const Text("View Profile"),
      ),
      subtitle: Text(
        "Joined ${formatDate(user.created_at!)}",
        style: const TextStyle(color: AppPallete.greyColor),
      ),
    );
  }
}
