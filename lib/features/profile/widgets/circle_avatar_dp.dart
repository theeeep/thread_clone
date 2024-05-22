import 'dart:io';

import 'package:flutter/material.dart';

class CircleAvatarDp extends StatelessWidget {
  final double radius;
  final String? url;
  final File? file;
  const CircleAvatarDp({super.key, this.radius = 80, this.url, this.file});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (url != null)
          CircleAvatar(
            backgroundImage: NetworkImage(url!),
            radius: radius,
          )
        else if (file != null)
          CircleAvatar(
            backgroundImage: FileImage(file!),
            radius: radius,
          )
        else
          CircleAvatar(
            radius: radius,
            backgroundImage: const AssetImage("assets/images/avatar.png"),
          ),
      ],
    );
  }
}
