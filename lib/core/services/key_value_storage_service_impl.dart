import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:teslo_shop/core/services/key_value_storage_service.dart';

// Implementation of the KeyValueStorageService using FlutterSecureStorage
class KeyValueStorageServiceImpl extends KeyValueStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<T?> getValue<T>(String key) async {
    String? storedValue = await _secureStorage.read(key: key);
    print('Stored value: $storedValue');

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
    await _secureStorage.write(key: key, value: value.toString());
    /* String? storedValue = await _secureStorage.read(key: key);
    print('Stored value SetKeyValue: $storedValue'); */
  }
}
