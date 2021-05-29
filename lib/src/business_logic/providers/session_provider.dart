import '../../storage/local_storage.dart';

class SessionProvider {
  final _storage = new LocalStorage();
  bool isLoggedIn = false;
  String authToken = "";

  Future<void> loadData() async {
    authToken = await _storage.readData("auth-token");
  }

  Future<void> writeAuthToken(String value) async {
    isLoggedIn = value != null ? true : false;
    await _storage.writeData("auth-token", value);
  }

  Future<String> readAuthToken() async {
    if (authToken == "") {
      authToken = await _storage.readData("auth-token"); 
    }
    return authToken;
  }

  Future<void> writeData(String key, String value) async {
    await _storage.writeData(key, value);
  }

  Future<String> readData(String key) async {
    return await _storage.readData(key);
  }

  Future<void> removeData(String key) async {
    await _storage.deleteData(key);
  }

  Future<dynamic> readAllData() async {
    return await _storage.readAllData();
  }
}