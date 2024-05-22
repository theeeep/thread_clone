import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/utils/helper.dart';
import 'package:thread_clone/features/profile_setting/controller/setting_controller.dart';

class Setting extends StatelessWidget {
  Setting({super.key});

  final settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                confirmDialog(
                  "Log Out",
                  "Are you sure want to log out!",
                  settingController.logOut,
                );
              },
              leading: const Icon(Icons.logout),
              title: const Text("Log Out"),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
