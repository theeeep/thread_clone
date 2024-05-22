import 'dart:io';

import 'package:flutter/material.dart';
import 'package:thread_clone/core/utils/helper.dart';

class CircleAvatarDp extends StatelessWidget {
  final double radius;
  final String? url;
  final File? file;
  const CircleAvatarDp({super.key, this.radius = 80, this.url, this.file});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (file != null)
          CircleAvatar(
            backgroundImage: FileImage(file!),
            radius: radius,
          )
        else if (url != null)
          CircleAvatar(
            backgroundImage: NetworkImage(getS3Url(url!)),
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
