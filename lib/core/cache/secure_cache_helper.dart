import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureCacheHelper {
  static late FlutterSecureStorage secureStorage;

  //! Here The Initialize of secure cache
  void initSecureCacheHelper() {
    secureStorage = const FlutterSecureStorage();
  }

  //! this method to put data in secure storage using key
  Future<void> saveData({
    required String key,
    required String value,
  }) async {
    await secureStorage.write(key: key, value: value);
  }

  //! this method to get data already saved in secure storage
  Future<String?> getData({required String key}) async {
    return await secureStorage.read(key: key);
  }

  //! remove data using specific key
  Future<void> removeData({required String key}) async {
    await secureStorage.delete(key: key);
  }

  //! this method to check if secure storage contains {key}
  Future<bool> containsKey({required String key}) async {
    return await secureStorage.containsKey(key: key);
  }

  //! clear all data
  Future<void> clearAllData() async {
    await secureStorage.deleteAll();
  }
}
