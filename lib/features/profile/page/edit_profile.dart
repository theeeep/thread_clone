import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/features/profile/controller/profile_controller.dart';
import 'package:thread_clone/features/profile/widgets/circle_avatar_dp.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final descEditingController = TextEditingController();
  final profileController = Get.find<ProfileController>();
  final supabaseService = Get.find<SupabaseService>();

  @override
  void initState() {
    if (supabaseService.currentUser.value?.userMetadata?["description"] !=
        null) {
      descEditingController.text =
          supabaseService.currentUser.value?.userMetadata?["description"];
    }
    super.initState();
  }

  @override
  void dispose() {
    descEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          Obx(
            () => TextButton(
              onPressed: () {
                profileController.updateProfile(
                    supabaseService.currentUser.value!.id,
                    descEditingController.text);
              },
              child: profileController.loading.value
                  ? const SizedBox(
                      height: 14,
                      width: 14,
                      child: CircularProgressIndicator(),
                    )
                  : const Text(
                      "Done",
                      style: TextStyle(fontSize: 18),
                    ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Center(
              child: Obx(
                () => Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatarDp(
                      file: profileController.image.value,
                      url: supabaseService
                          .currentUser.value?.userMetadata?["image"],
                    ),
                    IconButton(
                      onPressed: () {
                        profileController.pickImage();
                      },
                      icon: const CircleAvatar(
                        radius: 18,
                        backgroundColor: AppPallete.gradient2,
                        child: Icon(
                          Icons.edit,
                          color: AppPallete.whiteColor,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: descEditingController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Description",
                label: Text("Description"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
