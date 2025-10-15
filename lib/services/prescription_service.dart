import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';

import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class PrescriptionService {
  // Send prescription to a specific pharmacy
  static Future<Map<String, dynamic>> sendPrescription({
    required String userId,
    required String pharmacyId,
    required File prescriptionFile,
    String? notes,
  }) async {
    try {
      // Get auth token
      final token = await SharedPreferencesHelper.getToken();
      if (token == null) {
        return {
          'success': false,
          'message': 'Authentication token not found',
        };
      }

      // Create multipart request
      final uri = Uri.parse(ApiConstants.sendprescriptionapi
          .replaceAll(':userId', userId)
          .replaceAll(':pharmacyId', pharmacyId));

      final request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });

      // Add prescription file
      final prescriptionMultipart = await http.MultipartFile.fromPath(
        'prescriptionFile',
        prescriptionFile.path,
      );
      request.files.add(prescriptionMultipart);

      // Add notes if provided
      if (notes != null && notes.isNotEmpty) {
        request.fields['notes'] = notes;
      }

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Prescription upload response status: ${response.statusCode}');
      print('Prescription upload response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        return {
          'success': true,
          'message': responseData['message'] ?? 'Prescription sent successfully',
          'data': responseData,
        };
      } else {
        final errorData = json.decode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Failed to send prescription',
          'error': errorData,
        };
      }
    } catch (e) {
      print('Error sending prescription: $e');
      return {
        'success': false,
        'message': 'An error occurred while sending prescription: $e',
      };
    }
  }

  // Get all pharmacies for prescription submission
  static Future<Map<String, dynamic>> getAllPharmacies() async {
    try {
      final token = await SharedPreferencesHelper.getToken();
      if (token == null) {
        return {
          'success': false,
          'message': 'Authentication token not found',
        };
      }

      final response = await http.get(
        Uri.parse(ApiConstants.pharmacyService),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Get pharmacies response status: ${response.statusCode}');
      print('Get pharmacies response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return {
          'success': true,
          'data': responseData,
        };
      } else {
        final errorData = json.decode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Failed to fetch pharmacies',
        };
      }
    } catch (e) {
      print('Error getting pharmacies: $e');
      return {
        'success': false,
        'message': 'An error occurred while fetching pharmacies: $e',
      };
    }
  }

  // Submit query/question to pharmacy
  static Future<Map<String, dynamic>> submitQuery({
    required String userId,
    required String query,
    required String email,
    required String phone,
  }) async {
    try {
      final token = await SharedPreferencesHelper.getToken();
      if (token == null) {
        return {
          'success': false,
          'message': 'Authentication token not found',
        };
      }

      final response = await http.post(
        Uri.parse(ApiConstants.addqueryapi),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'userId': userId,
          'query': query,
          'email': email,
          'phone': phone,
        }),
      );

      print('Submit query response status: ${response.statusCode}');
      print('Submit query response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        return {
          'success': true,
          'message': responseData['message'] ?? 'Query submitted successfully',
          'data': responseData,
        };
      } else {
        final errorData = json.decode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Failed to submit query',
        };
      }
    } catch (e) {
      print('Error submitting query: $e');
      return {
        'success': false,
        'message': 'An error occurred while submitting query: $e',
      };
    }
  }

  // Validate prescription file
  static bool validatePrescriptionFile(File file) {
    // Check file size (max 10MB)
    if (file.lengthSync() > 10 * 1024 * 1024) {
      return false;
    }

    // Check file extension
    final extension = file.path.split('.').last.toLowerCase();
    const allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf'];
    
    return allowedExtensions.contains(extension);
  }

  // Get file size in readable format
  static String getFileSize(File file) {
    final bytes = file.lengthSync();
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}