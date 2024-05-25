import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/features/home/widgets/loading_widget.dart';
import 'package:thread_clone/features/home/widgets/post_card.dart';
import 'package:thread_clone/features/profile/widgets/comment_card_top_bar.dart';
import 'package:thread_clone/features/threads/controller/thread_controller.dart';

class ShowThreads extends StatefulWidget {
  const ShowThreads({super.key});

  @override
  State<ShowThreads> createState() => _ShowThreadsState();
}

class _ShowThreadsState extends State<ShowThreads> {
  final int threadId = Get.arguments;
  final threadController = Get.put(ThreadController());

  @override
  void initState() {
    threadController.fetchSingleThread(threadId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thread"),
        centerTitle: true,
      ),
      body: Obx(() => threadController.fetchThreadLoading.value
          ? const LoadingWidget()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  PostCard(post: threadController.posts.value),
                  const SizedBox(height: 20),

                  // Load thread replies
                  if (threadController.fetchCommentLoading.value)
                    const LoadingWidget()
                  else if (threadController.comments.isNotEmpty)
                    ListView.builder(
                      itemCount: threadController.comments.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      // TODO: Fix Comment Card with profile pic
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommentCardTopBar(
                          comment: threadController.comments[index],
                        ),
                      ),
                    )
                  else
                    const Center(
                      child: Text("No Reply"),
                    ),
                ],
              ),
            )),
    );
  }
}
