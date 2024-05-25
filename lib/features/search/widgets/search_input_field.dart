import 'package:flutter/material.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/core/utils/type_def.dart';

class SearchInputField extends StatelessWidget {
  final TextEditingController controller;
  final InputCallback callback;
  const SearchInputField(
      {super.key, required this.controller, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextField(
        controller: controller,
        onChanged: callback,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: AppPallete.gradient2,
          ),
          fillColor: const Color(0xff242424),
          filled: true,
          hintText: "Search ",
          hintStyle: const TextStyle(color: AppPallete.greyColor),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
