import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/models/services_model.dart';

class ServiceService {
  // static const String baseUrl = 'http://194.164.148.244:7021/api/service';
  
  // Headers for API requests
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Get all services
  Future<ServiceResponse> getAllServices() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.allServices),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return ServiceResponse.fromJson(data);
      } else {
        throw Exception('Failed to load services: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching services: $e');
    }
  }}