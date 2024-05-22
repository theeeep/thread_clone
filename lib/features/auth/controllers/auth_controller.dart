import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread_clone/core/services/storage_service.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/core/utils/helper.dart';
import 'package:thread_clone/core/utils/storage_keys.dart';
import 'package:thread_clone/routes/route_names.dart';

class AuthController extends GetxController {
  var signUpLoading = false.obs;
  var logInLoading = false.obs;

  // SignUp Method
  Future<void> signUp(String name, String email, String password) async {
    try {
      signUpLoading.value = true;
      final AuthResponse authResponse =
          await SupabaseService.supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {"name": name},
      );
      signUpLoading.value = false;

      if (authResponse.user != null) {
        StorageService.session
            .write(StorageKeys.userSession, authResponse.session!.toJson());
        Get.offAllNamed(RouteNames.home);
      }
    } on AuthException catch (e) {
      signUpLoading.value = false;
      debugPrint("Auth Controller AuthException: ${e.message}");
      showSnackBar("Authentication Error", e.message);
    } catch (error) {
      signUpLoading.value = false;
      debugPrint("Auth Controller Error: $error");
      showSnackBar("Error", "Something went wrong. Please try again.");
    }
  }

  // Log In User
  Future<void> logIn(String email, String password) async {
    try {
      logInLoading.value = true;
      final AuthResponse authResponse =
          await SupabaseService.supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      logInLoading.value = false;

      if (authResponse.user != null) {
        StorageService.session
            .write(StorageKeys.userSession, authResponse.session!.toJson());
        Get.offAllNamed(RouteNames.home);
      }
    } on AuthException catch (e) {
      logInLoading.value = false;
      debugPrint("Auth Controller AuthException: ${e.message}");
      showSnackBar("Authentication Error", e.message);
    } catch (error) {
      logInLoading.value = false;
      debugPrint("Auth Controller Error: $error");
      showSnackBar("Error", "Something went wrong. Please try again.");
    }
  }
}
