import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread_clone/core/services/storage_service.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/utils/helper.dart';
import 'package:thread_clone/core/utils/storage_keys.dart';
import 'package:thread_clone/routes/route_names.dart';

class AuthController extends GetxController {
  var signUpLoading = false.obs;
  var signInLoading = false.obs;

  Future<void> signUp(String name, String email, String password) async {
    try {
      signUpLoading.value = true;
      final AuthResponse authResponse = await SupabaseService
          .supabaseClient.auth
          .signUp(email: email, password: password, data: {"name": name});
      signUpLoading.value = false;

      if (authResponse.user != null) {
        StorageService.session
            .write(StorageKeys.userSession, authResponse.session!.toJson());
        Get.offAllNamed(RouteNames.home);
      }
    } on AuthException catch (e) {
      signUpLoading.value = false;
      showSnackBar("Authentication Error", e.message);
    }
  }

  // * Log In User
  Future<void> logIn(String email, String password) async {
    try {
      signInLoading.value = true;

      final AuthResponse authResponse = await SupabaseService
          .supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      signInLoading.value = false;

      if (authResponse.user != null) {
        StorageService.session
            .write(StorageKeys.userSession, authResponse.session!.toJson());
        Get.offAllNamed(RouteNames.home);
      }
    } on AuthException catch (e) {
      signInLoading.value = false;
      showSnackBar("Authentication Error", e.message);
    }
  }
}
