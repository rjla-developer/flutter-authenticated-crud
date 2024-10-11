import 'package:flutter_secure_storage/flutter_secure_storage.dart';
/* import 'package:shared_preferences/shared_preferences.dart'; */
import 'package:teslo_shop/core/services/key_value_storage_service.dart';

/* class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key, value) async {
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
 */

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<T?> getValue<T>(String key, value) async {
    String? storedValue = await _secureStorage.read(key: key);

    switch (T) {
      case const (int):
        return int.tryParse(storedValue!) as T?;
      case const (String):
        return storedValue as T?;

      default:
        throw UnimplementedError(
            'Get not implemented for type ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    await _secureStorage.delete(key: key);
    return true;
  }

  @override
  Future<void> setKeyValue<T>(String key, value) async {
    switch (T) {
      case const (int):
        await _secureStorage.write(key: key, value: value.toString());
        break;
      case const (String):
        await _secureStorage.write(key: key, value: value as String);
        break;

      default:
        throw UnimplementedError(
            'Set not implemented for type ${T.runtimeType}');
    }
  }
}
