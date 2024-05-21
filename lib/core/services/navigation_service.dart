import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/features/home/page/home_page.dart';
import 'package:thread_clone/features/notification/page/notification_page.dart';
import 'package:thread_clone/features/profile/page/profile_page.dart';
import 'package:thread_clone/features/search/page/search_page.dart';
import 'package:thread_clone/features/threads/page/add_thread.dart';

class NavigationService extends GetxService {
  var currentIndex = 0.obs;
  var lastIndex = 0.obs;

  // Page Lists
  List<Widget> pages() {
    return [
      const HomePage(),
      const SearchPage(),
      const AddThread(),
      const NotificationPage(),
      const ProfilePage(),
    ];
  }
}
