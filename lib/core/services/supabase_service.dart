import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread_clone/core/utils/env.dart';

class SupabaseService extends GetxService {
  @override
  void onInit() async {
    await Supabase.initialize(url: ENV.supabaseUrl, anonKey: ENV.supabaseKey);
    super.onInit();
  }

  static final SupabaseClient supabaseClient = Supabase.instance.client;
}
