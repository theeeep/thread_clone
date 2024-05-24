import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/services/navigation_service.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/features/threads/controller/thread_controller.dart';

class AddThreadAppbar extends StatelessWidget {
  AddThreadAppbar({super.key});
  final threadController = Get.find<ThreadController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xff242424),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.find<NavigationService>().backToPevPage();
                },
                icon: const Icon(Icons.close),
              ),
              const SizedBox(width: 100),
              const Text(
                "Add Thread",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Obx(() => TextButton(
                onPressed: () {
                  if (threadController.content.value.isNotEmpty) {
                    threadController.storeThreads(
                        Get.find<SupabaseService>().currentUser.value!.id);
                  }
                },
                child: threadController.loading.value
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Text(
                        "Post",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                threadController.content.value.isNotEmpty
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                            color: threadController.content.value.isNotEmpty
                                ? AppPallete.gradient2
                                : AppPallete.greyColor),
                      ),
              ))
        ],
      ),
    );
  }
}
