import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/services/navigation_service.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';

class Btmnavbar extends StatelessWidget {
  Btmnavbar({super.key});
  final navigationService = Get.put(NavigationService());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationService.currentIndex.value,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            indicatorColor: AppPallete.transparentColor,
            onDestinationSelected: (value) =>
                navigationService.updateIndex(value),
            destinations: const <Widget>[
              NavigationDestination(
                icon: ImageIcon(
                  AssetImage('assets/icons/Home.png'),
                ),
                label: "Home",
                selectedIcon: ImageIcon(
                  AssetImage('assets/icons/Home.png'),
                  color: AppPallete.gradient2,
                  size: 28,
                ),
              ),
              NavigationDestination(
                icon: ImageIcon(
                  AssetImage('assets/icons/Search.png'),
                ),
                label: "Search",
                selectedIcon: ImageIcon(
                  AssetImage('assets/icons/Search.png'),
                  color: AppPallete.gradient2,
                  size: 28,
                ),
              ),
              NavigationDestination(
                icon: ImageIcon(
                  AssetImage('assets/icons/Compose.png'),
                ),
                label: "Add",
                selectedIcon: ImageIcon(
                  AssetImage('assets/icons/Compose.png'),
                  color: AppPallete.gradient2,
                  size: 28,
                ),
              ),
              NavigationDestination(
                icon: ImageIcon(
                  AssetImage('assets/icons/Heart.png'),
                ),
                label: "Notification",
                selectedIcon: ImageIcon(
                  AssetImage('assets/icons/Heart.png'),
                  color: AppPallete.gradient2,
                  size: 28,
                ),
              ),
              NavigationDestination(
                icon: ImageIcon(
                  AssetImage('assets/icons/Person.png'),
                ),
                label: "Profile",
                selectedIcon: ImageIcon(
                  AssetImage('assets/icons/Person.png'),
                  color: AppPallete.gradient2,
                  size: 28,
                ),
              ),
            ],
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeInCirc,
            switchOutCurve: Curves.easeOutCubic,
            child:
                navigationService.pages()[navigationService.currentIndex.value],
          ),
        ));
  }
}
