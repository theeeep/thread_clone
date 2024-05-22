import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Text("Profile Settings"),
          ],
        ),
      ),
    );
  }
}
