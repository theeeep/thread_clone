import 'package:flutter/material.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: CircularProgressIndicator(
          color: AppPallete.gradient2,
        ),
      ),
    );
  }
}
