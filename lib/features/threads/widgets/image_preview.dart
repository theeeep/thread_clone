import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/features/threads/controller/thread_controller.dart';

class ImagePreview extends StatelessWidget {
  ImagePreview({super.key});
  final threadController = Get.put(ThreadController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(
              threadController.image.value!,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: CircleAvatar(
              backgroundColor: Colors.white38,
              radius: 18,
              child: IconButton(
                onPressed: () {
                  threadController.image.value = null;
                },
                icon: const ImageIcon(
                  AssetImage("assets/icons/close.png"),
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
