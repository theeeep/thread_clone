import 'package:get/route_manager.dart';
import 'package:thread_clone/features/auth/pages/login_page.dart';
import 'package:thread_clone/features/auth/pages/signup_page.dart';
import 'package:thread_clone/features/btmnavbar.dart';
import 'package:thread_clone/routes/route_names.dart';
import 'package:thread_clone/features/home/page/home_page.dart';

class Routes {
  static final pages = [
    GetPage(name: RouteNames.btmNavBar, page: () => Btmnavbar()),
    GetPage(name: RouteNames.home, page: () => const HomePage()),
    GetPage(name: RouteNames.logIn, page: () => const LoginPage()),
    GetPage(name: RouteNames.signUp, page: () => const SignupPage()),
  ];
}
