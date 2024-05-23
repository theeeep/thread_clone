import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/features/home/controller/home_controller.dart';
import 'package:thread_clone/features/home/widgets/loading_widget.dart';
import 'package:thread_clone/features/home/widgets/post_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 40,
                  height: 40,
                ),
              ),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: Obx(
                () => homeController.loading.value
                    ? const LoadingWidget()
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        itemCount: homeController.posts.length,
                        itemBuilder: (context, index) =>
                            PostCard(post: homeController.posts[index]),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
