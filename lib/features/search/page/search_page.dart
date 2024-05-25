import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/features/home/widgets/loading_widget.dart';
import 'package:thread_clone/features/search/controller/search_user_controller.dart';
import 'package:thread_clone/features/search/widgets/search_input_field.dart';
import 'package:thread_clone/features/search/widgets/user_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final textEditingController = TextEditingController();
  final searchController = Get.put(SearchUserController());

  void searchUser(String? name) async {
    if (name != null) {
      searchController.searchUser(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            centerTitle: true,
            title: const Text(
              "Search",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            expandedHeight: GetPlatform.isIOS ? 110 : 105,
            collapsedHeight: GetPlatform.isIOS ? 90 : 80,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(
                top: GetPlatform.isIOS ? 105 : 80,
                left: 10,
                right: 10,
              ),
              child: SearchInputField(
                  controller: textEditingController, callback: searchUser),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => searchController.searchLoading.value
                  ? const LoadingWidget()
                  : Column(
                      children: [
                        if (searchController.users.isNotEmpty)
                          ListView.builder(
                            itemCount: searchController.users.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                UserTile(user: searchController.users[index]),
                          )
                        else if (searchController.users.isEmpty &&
                            searchController.notFound.value == true)
                          const Text("No User found")
                        else
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text("Search Your Friends"),
                            ),
                          ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
