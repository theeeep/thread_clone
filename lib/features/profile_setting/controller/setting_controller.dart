import 'package:get/get.dart';
import 'package:thread_clone/core/services/storage_service.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/utils/storage_keys.dart';
import 'package:thread_clone/routes/route_names.dart';

class SettingController extends GetxController {
  void logOut() async {
    // * Remove session from local storage
    StorageService.session.remove(StorageKeys.userSession);
    await SupabaseService.supabaseClient.auth.signOut();
    Get.offAllNamed(RouteNames.logIn);
  }
}
