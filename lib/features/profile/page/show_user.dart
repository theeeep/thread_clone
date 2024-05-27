import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/features/home/widgets/loading_widget.dart';
import 'package:thread_clone/features/home/widgets/post_card.dart';
import 'package:thread_clone/features/profile/controller/profile_controller.dart';
import 'package:thread_clone/features/profile/widgets/circle_avatar_dp.dart';
import 'package:thread_clone/features/profile/widgets/profile_comment_card.dart';
import 'package:thread_clone/routes/route_names.dart';

class ShowUser extends StatefulWidget {
  const ShowUser({super.key});

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  final String userId = Get.arguments;
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    profileController.fetchUserProfile(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ImageIcon(
          AssetImage('assets/icons/Globe.png'),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(RouteNames.profileSetting),
            icon: const ImageIcon(
              AssetImage('assets/icons/Text_Align.png'),
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 110,
                collapsedHeight: 110,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (profileController.userLoading.value)
                                  const LoadingWidget()
                                else
                                  Text(
                                    profileController
                                        .user.value.metadata!.name!,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                SizedBox(
                                  width: context.width * 0.70,
                                  child: Text(
                                    profileController
                                            .user.value.metadata?.description ??
                                        "Add Description",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CircleAvatarDp(
                            radius: 45,
                            url: profileController.user.value.metadata?.image,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: SliverAppBarDelegate(
                  const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: AppPallete.gradient2,
                    labelColor: AppPallete.gradient2,
                    tabs: [
                      Tab(text: "Threads"),
                      Tab(text: "Replies"),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Obx(
                () => SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      if (profileController.postLoading.value)
                        const LoadingWidget()
                      else if (profileController.posts.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: profileController.posts.length,
                          itemBuilder: (context, index) => PostCard(
                            post: profileController.posts[index],
                          ),
                        )
                      else
                        const Center(
                          child: Text("No Data Found"),
                        ),
                    ],
                  ),
                ),
              ),
              Obx(() => SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        if (profileController.commentLoading.value)
                          const LoadingWidget()
                        else if (profileController.comments.isNotEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: profileController.comments.length,
                            itemBuilder: (context, index) => ProfileCommentCard(
                              comment: profileController.comments[index],
                            ),
                          )
                        else
                          const Center(
                            child: Text("No Data Found"),
                          ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

// * Sliver Persistent Header Class
class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  SliverAppBarDelegate(this._tabBar);

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppPallete.blackColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
