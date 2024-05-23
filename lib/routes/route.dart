import 'package:get/route_manager.dart';
import 'package:thread_clone/features/auth/pages/login_page.dart';
import 'package:thread_clone/features/auth/pages/signup_page.dart';
import 'package:thread_clone/features/btmnavbar.dart';
import 'package:thread_clone/features/comments/pages/add_comment.dart';
import 'package:thread_clone/features/profile/page/edit_profile.dart';
import 'package:thread_clone/features/profile_setting/page/setting.dart';
import 'package:thread_clone/routes/route_names.dart';
import 'package:thread_clone/features/home/page/home_page.dart';

class Routes {
  static final pages = [
    GetPage(name: RouteNames.btmNavBar, page: () => Btmnavbar()),
    GetPage(
      name: RouteNames.home,
      page: () => HomePage(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: RouteNames.logIn,
      page: () => const LoginPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteNames.signUp,
      page: () => const SignupPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteNames.editProfile,
      page: () => const EditProfile(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.profileSetting,
      page: () => Setting(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: RouteNames.commentPage,
      page: () => AddComment(),
      transition: Transition.downToUp,
    ),
  ];
}
