import 'package:flutter/material.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';

class AuthField extends StatelessWidget {
  final String hintText, label;
  final TextEditingController controller;
  final bool isObscureText;
  const AuthField({
    super.key,
    required this.hintText,
    required this.label,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppPallete.greyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppPallete.gradient2),
        ),
        hintText: hintText,
        label: Text(label),
        labelStyle: const TextStyle(
          color: AppPallete.gradient2,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      obscureText: isObscureText,
      obscuringCharacter: "*",
    );
  }
}
