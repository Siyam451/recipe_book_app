import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const _tokenKey = "access-token";
  static const _favoriteKey = "favorites";

  static String? accessToken;

  /// SAVE TOKEN
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);

    accessToken = token;
  }

  /// GET TOKEN
  static Future<void> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(_tokenKey);
  }

  /// CHECK LOGIN
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) != null;
  }

  /// SAVE FAVORITES
  static Future<void> saveFavorites(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoriteKey, ids);
  }

  /// GET FAVORITES
  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoriteKey) ?? [];
  }

  /// CLEAR ALL
  static Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    accessToken = null;
  }
}