// services/notification_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/models/notification_model.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class NotificationService {
  Future<List<NotificationModel>> fetchNotifications(String userId) async {
    try {
      final token = await SharedPreferencesHelper.getToken();
      final url = ApiConstants.getNotifications.replaceAll(':userId', userId);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      


            print('notification statussss codeeeeeeeeeeeeeeeeeeeeee ${response.statusCode}');
            print('notification bodyyyyyyyyyyyyyyyyyyyyyyy ${response.body}');


      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final List<dynamic> notificationsJson = body['notifications'] ?? [];
        return notificationsJson
            .map((json) => NotificationModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Failed to load notifications (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error fetching notifications: $e');
    }
  }
}
