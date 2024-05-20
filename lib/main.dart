import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:thread_clone/core/themes/theme.dart';
import 'package:thread_clone/routes/route.dart';
import 'package:thread_clone/routes/route_names.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Thread',
      theme: AppTheme.theme,
      getPages: Routes.pages,
      initialRoute: RouteNames.logIn,
    );
  }
}
