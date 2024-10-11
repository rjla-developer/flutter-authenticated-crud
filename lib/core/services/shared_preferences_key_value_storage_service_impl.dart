import 'package:shared_preferences/shared_preferences.dart';
import 'package:teslo_shop/core/services/key_value_storage_service.dart';

// Implementation of the KeyValueStorageService using SharedPreferences

class SharedPreferencesKeyValueStorageServiceImpl
    extends KeyValueStorageService {
  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPreferences();

    switch (T) {
      case const (int):
        return prefs.getInt(key) as T?;
      case const (String):
        return prefs.getString(key) as T?;

      default:
        throw UnimplementedError(
            'Get not implemented for type ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPreferences();
    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, value) async {
    final prefs = await getSharedPreferences();

    switch (T) {
      case const (int):
        prefs.setInt(key, value as int);
        break;
      case const (String):
        prefs.setString(key, value as String);
        break;

      default:
        throw UnimplementedError(
            'Set not implemented for type ${T.runtimeType}');
    }
  }
}
