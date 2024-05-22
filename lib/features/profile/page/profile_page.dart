import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';
import 'package:thread_clone/features/profile/controller/profile_controller.dart';
import 'package:thread_clone/features/profile/widgets/btn_style.dart';
import 'package:thread_clone/features/profile/widgets/circle_avatar_dp.dart';
import 'package:thread_clone/routes/route_names.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profileControllr = Get.put(ProfileController());
  final supabaseService = Get.find<SupabaseService>();

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
                expandedHeight: 160,
                collapsedHeight: 160,
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
                                Text(
                                  supabaseService
                                      .currentUser.value!.userMetadata?["name"],
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: context.width * 0.70,
                                  child: Text(
                                    supabaseService.currentUser.value
                                            ?.userMetadata?["description"] ??
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
                            url: supabaseService
                                .currentUser.value?.userMetadata?["image"],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>
                                  Get.toNamed(RouteNames.editProfile),
                              style: customOutlineBtnStyle(),
                              child: const Text("Edit profile"),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: customOutlineBtnStyle(),
                              child: const Text("Share profile"),
                            ),
                          ),
                        ],
                      ),
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
                    tabs: [
                      Tab(text: "Threads"),
                      Tab(text: "Replies"),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              Text("I'm Threads"),
              Text("I'm Replies"),
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
