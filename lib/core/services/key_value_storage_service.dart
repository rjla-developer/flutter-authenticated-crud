abstract class KeyValueStorageService {
  Future<void> setKeyValue<T>(String key, dynamic value);
  Future<T?> getValue<T>(String key, dynamic value);
  Future<bool> removeKey(String key);
}
