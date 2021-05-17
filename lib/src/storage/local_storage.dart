import 'dart:core';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {

  final _storage = new FlutterSecureStorage();

  LocalStorage();

  Future<void> writeData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<dynamic> readData(String key) async {
    return await _storage.read(key: key);
  }

  Future<dynamic> deleteData(String key) async {
    return await _storage.delete(key: key);
  }

  Future<dynamic> readAllData() async {
    return await _storage.readAll();
  }
}