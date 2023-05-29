import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalStorage {
  final String tokenKey = 'token';

  Future<String> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(tokenKey, token);
    return token;
  }

  Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(tokenKey);
  }

  Future<bool> isTokenExist() async {
    final pref = await SharedPreferences.getInstance();
    return pref.containsKey(tokenKey);
  }

  Future<void> removeToken() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(tokenKey);
  }

  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(tokenKey);
  }
}
