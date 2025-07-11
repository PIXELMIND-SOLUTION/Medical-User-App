import 'package:medical_user_app/models/user_model.dart';

class AuthResponse {
  final String message;
  final String? token;
  final User user;

  AuthResponse({
    required this.message,
    this.token,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      message: json['message'] ?? '',
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}