import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/features/home/controller/home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final homeController = Get.put(HomeController());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello"),
      ),
      body: const Center(
        child: Text("Home"),
      ),
    );
  }
}
