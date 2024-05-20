import 'package:get/route_manager.dart';
import 'package:thread_clone/pages/auth/login_page.dart';
import 'package:thread_clone/pages/auth/signup_page.dart';
import 'package:thread_clone/routes/route_names.dart';
import 'package:thread_clone/pages/home_page.dart';

class Routes {
  static final pages = [
    GetPage(name: RouteNames.home, page: () => const Home()),
    GetPage(name: RouteNames.logIn, page: () => const LoginPage()),
    GetPage(name: RouteNames.signUp, page: () => const SignupPage()),
  ];
}
