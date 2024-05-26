import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/features/home/model/post_model.dart';
import 'package:thread_clone/features/threads/controller/thread_controller.dart';
import 'package:thread_clone/routes/route_names.dart';

class PostBottomBar extends StatefulWidget {
  final PostModel post;

  const PostBottomBar({super.key, required this.post});

  @override
  State<PostBottomBar> createState() => _PostBottomBarState();
}

class _PostBottomBarState extends State<PostBottomBar> {
  final threadController = Get.put(ThreadController());
  final supabaseService = Get.find<SupabaseService>();
  String likeStatus = "";

  void likeDislike(String status) async {
    setState(() {
      likeStatus = status;
    });

    if (likeStatus == "0") {
      widget.post.likes = [];
    }

    await threadController.likeDislike(status, widget.post.id!,
        widget.post.userId!, supabaseService.currentUser.value!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        likeStatus == "1" || widget.post.likes!.isNotEmpty
            ? IconButton(
                onPressed: () {
                  likeDislike("0");
                },
                icon: const ImageIcon(
                  AssetImage("assets/icons/HeartLike.png"),
                  size: 27,
                  color: AppPallete.gradient2,
                ),
              )
            : IconButton(
                onPressed: () {
                  likeDislike("1");
                },
                icon: const ImageIcon(
                  AssetImage("assets/icons/Heart.png"),
                  size: 25,
                ),
              ),
        Text(
          "${widget.post.likeCount}",
          style: const TextStyle(fontSize: 18),
        ),
        IconButton(
          onPressed: () {
            Get.toNamed(RouteNames.addcommentPage, arguments: widget.post);
          },
          icon: const ImageIcon(
            AssetImage("assets/icons/comment.png"),
            size: 28,
          ),
        ),
        Text(
          "${widget.post.commentCount}",
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
