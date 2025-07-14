import 'package:medical_user_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesHelper {
  static const String _keyToken = 'auth_token';
  static const String _keyUser = 'user_data';
  static const String _keyIsLoggedIn = 'is_logged_in';

  static SharedPreferences? _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Save auth token
  static Future<bool> saveToken(String token) async {
    await init();
    return _prefs!.setString(_keyToken, token);
  }

  // Get auth token
  static Future<String?> getToken() async {
    await init();
    return _prefs!.getString(_keyToken);
  }

  // Save user data
  static Future<bool> saveUser(User user) async {
    await init();
    String userJson = json.encode(user.toJson());
    return _prefs!.setString(_keyUser, userJson);
  }

  // Get user data
  static Future<User?> getUser() async {
    await init();
    String? userJson = _prefs!.getString(_keyUser);
    if (userJson != null) {
      Map<String, dynamic> userMap = json.decode(userJson);
      return User.fromJson(userMap);
    }
    return null;
  }

  // Save login status
  static Future<bool> setLoggedIn(bool isLoggedIn) async {
    await init();
    return _prefs!.setBool(_keyIsLoggedIn, isLoggedIn);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    await init();
    return _prefs!.getBool(_keyIsLoggedIn) ?? false;
  }

  // Save complete auth data
  static Future<bool> saveAuthData({
    required String token,
    required User user,
  }) async {
    await init();
    final results = await Future.wait([
      saveToken(token),
      saveUser(user),
      setLoggedIn(true),
    ]);
    return results.every((result) => result);
  }

  // Clear all auth data (logout)
  static Future<bool> clearAuthData() async {
    await init();
    final results = await Future.wait([
      _prefs!.remove(_keyToken),
      _prefs!.remove(_keyUser),
      setLoggedIn(false),
    ]);
    return results.every((result) => result);
  }

  // Get complete auth data
  static Future<Map<String, dynamic>> getAuthData() async {
    await init();
    final token = await getToken();
    final user = await getUser();
    final loggedIn = await isLoggedIn();

    return {
      'token': token,
      'user': user,
      'isLoggedIn': loggedIn,
    };
  }
}