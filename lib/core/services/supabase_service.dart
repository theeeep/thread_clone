import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread_clone/core/utils/env.dart';

class SupabaseService extends GetxService {
  Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() async {
    await Supabase.initialize(url: ENV.supabaseUrl, anonKey: ENV.supabaseKey);
    currentUser.value = supabaseClient.auth.currentUser;
    listenAuthChanges();
    super.onInit();
  }

  static final SupabaseClient supabaseClient = Supabase.instance.client;

  // * Listen Auth Changes
  void listenAuthChanges() {
    supabaseClient.auth.onAuthStateChange.listen(
      (data) {
        final AuthChangeEvent event = data.event;

        if (event == AuthChangeEvent.userUpdated) {
          debugPrint("Inside the user updated session $data");
          currentUser.value = data.session?.user;
        } else if (event == AuthChangeEvent.signedIn) {
          currentUser.value = data.session?.user;
        }
      },
    );
  }
}
