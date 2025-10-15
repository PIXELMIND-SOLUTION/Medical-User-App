
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';
import '../models/category_model.dart';

class CategoryService {
  // static const String baseUrl = 'http://194.164.148.244:7021/api/category';
  static const Duration timeoutDuration = Duration(seconds: 30);

  Future<CategoryResponse> getAllCategories({
    String? serviceName,
    required String languageCode, // Make required to ensure it's always passed
  }) async {
    try {
      Uri uri;

      if (serviceName != null && serviceName.isNotEmpty) {
        uri = Uri.parse(ApiConstants.allCategories).replace(
          queryParameters: {'serviceName': serviceName.toLowerCase()},
        );
      } else {
        uri = Uri.parse(ApiConstants.allCategories);
      }

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Accept-Language': languageCode, 
        },
      ).timeout(timeoutDuration);

      final Map<String, dynamic> jsonData = json.decode(response.body);
      return CategoryResponse.fromJson(jsonData);
    } catch (e) {
      throw CategoryException('Failed to fetch categories: ${e.toString()}');
    }
  }
}


class CategoryException implements Exception {
  final String message;
  
  CategoryException(this.message);
  
  @override
  String toString() => 'CategoryException: $message';
}