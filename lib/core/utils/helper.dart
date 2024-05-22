import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/core/utils/env.dart';
import 'package:thread_clone/features/profile_setting/widgets/dialog_box.dart';
import 'package:uuid/uuid.dart';

void showSnackBar(String title, String message) {
  Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      snackStyle: SnackStyle.FLOATING,
      borderRadius: 10,
      duration: const Duration(seconds: 3),
      backgroundGradient: const LinearGradient(
        colors: [
          AppPallete.gradient1,
          AppPallete.gradient2,
          AppPallete.gradient3
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
      icon: const Icon(
        Icons.info_outline,
        color: Colors.white,
        size: 30,
      ),
    ),
  );
}

// * Pick image from gallery
Future<File?> pickImageFromGallery() async {
  const uuid = Uuid();
  final picker = ImagePicker();
  final XFile? file = await picker.pickImage(source: ImageSource.gallery);
  if (file == null) return null;
  final dir = Directory.systemTemp;
  final targetPath = "${dir.absolute.path}/${uuid.v6()}.jpg";
  File image = await compressImage(File(file.path), targetPath);
  return image;
}

// * Compress image file
Future<File> compressImage(File file, String targetPath) async {
  var result = await FlutterImageCompress.compressAndGetFile(
      file.path, targetPath,
      quality: 70);
  return File(result!.path);
}

// * get s3Bucket url
String getS3Url(String path) {
  return "${ENV.supabaseUrl}/storage/v1/object/public/$path";
}

// * Confirm Dialog
void confirmDialog(String title, String subTitle, VoidCallback callback) {
  Get.dialog(
    DialogBox(
      title: title,
      subTitle: subTitle,
      callback: callback,
    ),
  );
}
