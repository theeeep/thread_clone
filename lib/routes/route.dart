import 'package:get/route_manager.dart';
import 'package:thread_clone/routes/route_names.dart';
import 'package:thread_clone/views/home.dart';

class Routes {
  static final pages = [
    GetPage(name: RouteNames.home, page: () => const Home()),
  ];
}
