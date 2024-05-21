import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/services/navigation_service.dart';

class Btmnavbar extends StatelessWidget {
  Btmnavbar({super.key});
  final navigationService = Get.put(NavigationService());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationService.currentIndex.value,
            destinations: const <Widget>[
              NavigationDestination(
                icon: ImageIcon(
                  AssetImage('assets/icons/Home.png'),
                  color: Colors.grey,
                ),
                label: "Home",
                selectedIcon: ImageIcon(
                  AssetImage('assets/icons/Home.png'),
                ),
              ),
              NavigationDestination(
                icon: ImageIcon(
                  AssetImage('assets/icons/Search.png'),
                  color: Colors.grey,
                ),
                label: "Search",
                selectedIcon: ImageIcon(
                  AssetImage('assets/icons/Search.png'),
                ),
              ),
              NavigationDestination(
                icon: ImageIcon(
                  AssetImage('assets/icons/Compose.png'),
                  color: Colors.grey,
                ),
                label: "Add",
                selectedIcon: ImageIcon(
                  AssetImage('assets/icons/Compose.png'),
                ),
              ),
              NavigationDestination(
                icon: ImageIcon(
                  AssetImage('assets/icons/Heart.png'),
                  color: Colors.grey,
                ),
                label: "Notification",
                selectedIcon: ImageIcon(
                  AssetImage('assets/icons/Heart.png'),
                ),
              ),
              NavigationDestination(
                icon: ImageIcon(
                  AssetImage('assets/icons/Person.png'),
                  color: Colors.grey,
                ),
                label: "Profile",
                selectedIcon: ImageIcon(
                  AssetImage('assets/icons/Person.png'),
                ),
              ),
            ],
          ),
        ));
  }
}
