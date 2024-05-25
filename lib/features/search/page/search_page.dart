import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/features/search/widgets/search_input_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

  void searchUser(String? name) async {
    if (name != null) {}
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
                  controller: controller, callback: searchUser),
            ),
          )
        ],
      ),
    );
  }
}
