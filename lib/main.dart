import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thread_clone/core/services/storage_service.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/themes/theme.dart';
import 'package:thread_clone/routes/route.dart';
import 'package:thread_clone/routes/route_names.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  Get.put(SupabaseService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Thread',
      theme: AppTheme.theme,
      getPages: Routes.pages,
      initialRoute: StorageService.userSession != null
          ? RouteNames.btmNavBar
          : RouteNames.logIn,
    );
  }
}
