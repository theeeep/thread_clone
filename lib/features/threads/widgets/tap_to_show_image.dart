import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/utils/helper.dart';

class TapToShowImage extends StatelessWidget {
  final String image = Get.arguments;
  TapToShowImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.network(
          getS3Url(image),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
