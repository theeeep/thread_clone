import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/features/profile/widgets/circle_avatar_dp.dart';
import 'package:thread_clone/features/threads/controller/thread_controller.dart';
import 'package:thread_clone/features/threads/widgets/add_thread_appbar.dart';

class AddThread extends StatelessWidget {
  AddThread({super.key});
  final supabaseService = Get.find<SupabaseService>();
  final threadController = Get.put(ThreadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AddThreadAppbar(),
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
                          onTap: () {},
                          child: Image.asset("assets/icons/thread.png"),
                        ),
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
