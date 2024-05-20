import 'package:flutter/material.dart';
import 'package:thread_clone/core/themes/theme.dart';
import 'package:thread_clone/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Thread',
      theme: theme,
      home: const Home(),
    );
  }
}
