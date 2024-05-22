import 'package:get_storage/get_storage.dart';
import 'package:thread_clone/core/utils/storage_keys.dart';

class StorageService {
  static final GetStorage session = GetStorage();

// * Read user session
  static dynamic userSession = session.read(StorageKeys.userSession);
}
