import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/core/utils/helper.dart';
import 'package:thread_clone/features/home/model/user_model.dart';
import 'package:thread_clone/features/profile/widgets/btn_style.dart';
import 'package:thread_clone/features/profile/widgets/circle_avatar_dp.dart';
import 'package:thread_clone/routes/route_names.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  final supabaseService = Get.find<SupabaseService>();

  UserTile({
    super.key,
    required this.user,
  });

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
        onPressed: () {
          if (user.id == supabaseService.currentUser.value!.id) {
            Get.toNamed(RouteNames.showProfile);
          } else {
            Get.toNamed(RouteNames.showUser, arguments: user.id);
          }
        },
        style: customOutlineBtnStyle(),
        child: const Text("View Profile"),
      ),
      subtitle: Text(
        "Joined ${formatDate(user.createdAt!)}",
        style: const TextStyle(color: AppPallete.greyColor),
      ),
    );
  }
}
