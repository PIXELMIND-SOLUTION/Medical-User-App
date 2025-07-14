import 'package:http/http.dart' as http;
import 'package:medical_user_app/models/auth_response.dart';
import 'dart:convert';

import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class AuthService {
  static const String baseUrl = 'http://194.164.148.244:7021/api';
  
  // Register user
  static Future<AuthResponse> register({
    required String name,
    required String mobile,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/users/register');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'mobile': mobile,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return AuthResponse.fromJson(data);
      } else {
        throw Exception('Registration failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error during registration: $e');
    }
  }

  // Login user
  static Future<AuthResponse> login({
    required String mobile,
  }) async {
    try {
            print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${mobile}");

      final url = Uri.parse('$baseUrl/users/login');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'mobile': mobile,
        }),
      );

      print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AuthResponse.fromJson(data);
      } else {
        throw Exception('Login failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error during login: $e');
    }
  }

}
