import 'dart:async';

import 'package:get/get.dart';
import 'package:thread_clone/core/services/supabase_service.dart';
import 'package:thread_clone/features/home/model/user_model.dart';

class SearchUserController extends GetxController {
  var searchLoading = false.obs;
  var notFound = false.obs;
  RxList<UserModel> users = RxList<UserModel>();
  Timer? _debounce;

  Future<void> searchUser(String name) async {
    searchLoading.value = true;
    notFound.value = false;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (name.isNotEmpty) {
        final List<dynamic> data = await SupabaseService.supabaseClient
            .from("users")
            .select("*")
            .ilike("metadata->>name", "%$name%");
        searchLoading.value = false;
        if (data.isNotEmpty) {
          users.value = [for (var item in data) UserModel.fromJson(item)];
        } else {
          notFound.value = true;
        }
      }
      searchLoading.value = false;
    });
  }
}
