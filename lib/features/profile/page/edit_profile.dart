import 'package:flutter/material.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Done",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("assets/images/avatar.png"),
                  ),
                  IconButton(
                    onPressed: () {},
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
            const SizedBox(height: 20),
            TextFormField(
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
