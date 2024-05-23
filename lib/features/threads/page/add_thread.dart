import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/features/profile/widgets/circle_avatar_dp.dart';
import 'package:thread_clone/features/threads/controller/thread_controller.dart';
import 'package:thread_clone/features/threads/widgets/add_thread_appbar.dart';
import 'package:thread_clone/features/threads/widgets/image_preview.dart';

class AddThread extends StatefulWidget {
  const AddThread({super.key});

  @override
  State<AddThread> createState() => _AddThreadState();
}

class _AddThreadState extends State<AddThread> {
  final supabaseService = Get.find<SupabaseService>();
  final threadController = Get.put(ThreadController());
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 1.2;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddThreadAppbar(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => CircleAvatarDp(
                      radius: 30,
                      url: supabaseService
                          .currentUser.value!.userMetadata?["image"],
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: context.width * 0.80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            supabaseService
                                .currentUser.value!.userMetadata?["name"],
                          ),
                        ),
                        TextField(
                          autofocus: true,
                          controller: threadController.textEditingController,
                          onChanged: (value) =>
                              threadController.content.value = value,
                          style: const TextStyle(fontSize: 14),
                          minLines: 1,
                          maxLines: 10,
                          maxLength: 100,
                          decoration: const InputDecoration(
                            hintText: "Add a thread",
                            border: InputBorder.none,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => threadController.pickImage(),
                          onTapDown: _onTapDown,
                          onTapUp: _onTapUp,
                          onTapCancel: _onTapCancel,
                          child: AnimatedScale(
                            scale: _scale,
                            duration: const Duration(milliseconds: 100),
                            child: Image.asset(
                              "assets/icons/thread.png",
                              width: 30,
                              height: 30,
                              color: AppPallete.gradient2,
                            ),
                          ),
                        ),
                        // * Preview select image
                        Obx(() => Column(
                              children: [
                                if (threadController.image.value != null)
                                  ImagePreview(),
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
