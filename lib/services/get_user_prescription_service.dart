import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/models/prescription_model.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class GetUserPrescriptionService {
  static const Duration _timeout = Duration(seconds: 30);

  /// Fetch all user prescriptions
  static Future<List<UserPrescription>> getUserPrescriptions() async {
    try {
      // Get user from shared preferences
      final user = await SharedPreferencesHelper.getUser();
      if (user == null || user.id.isEmpty) {
        throw Exception('User not found. Please login again.');
      }

      // Get auth token
      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Authentication token not found. Please login again.');
      }

      print('Fetching prescriptions for user: ${user.id}');

      // Build URL with user ID
      final url = ApiConstants.getuserprescription.replaceAll(':userId', user.id);
      print('Request URL: $url');

      // Make API request
      final response = await http
          .get(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(_timeout);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        
        // Check if the response has the expected structure
        if (!responseData.containsKey('prescriptions')) {
          print('Warning: Response does not contain prescriptions key');
          return [];
        }

        final List<dynamic> prescriptionsData = responseData['prescriptions'];
        
        // Convert to UserPrescription objects
        List<UserPrescription> prescriptions = prescriptionsData
            .map((data) => UserPrescription.fromJson(data))
            .toList();

        print('Successfully fetched ${prescriptions.length} prescriptions');
        return prescriptions;

      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized. Please login again.');
      } else if (response.statusCode == 404) {
        print('No prescriptions found for user');
        return [];
      } else {
        // Try to parse error message from response
        String errorMessage = 'Failed to fetch prescriptions';
        try {
          final errorData = json.decode(response.body);
          errorMessage = errorData['message'] ?? errorMessage;
        } catch (e) {
          print('Could not parse error response: $e');
        }
        
        throw Exception('$errorMessage (Status: ${response.statusCode})');
      }

    } on SocketException {
      throw Exception('No internet connection. Please check your network.');
    } on http.ClientException {
      throw Exception('Network error. Please try again.');
    } on FormatException catch (e) {
      print('JSON parsing error: $e');
      throw Exception('Invalid response format from server.');
    } catch (e) {
      print('Error in getUserPrescriptions: $e');
      
      // Re-throw known exceptions
      if (e is Exception) {
        rethrow;
      }
      
      // Wrap unknown errors
      throw Exception('An unexpected error occurred: $e');
    }
  }

  /// Helper method to get file size from URL (if needed)
  static Future<String> getImageSize(String imageUrl) async {
    try {
      final response = await http.head(Uri.parse(imageUrl)).timeout(_timeout);
      
      if (response.statusCode == 200) {
        final contentLength = response.headers['content-length'];
        if (contentLength != null) {
          final bytes = int.parse(contentLength);
          return _formatBytes(bytes);
        }
      }
      
      return 'Unknown size';
    } catch (e) {
      print('Error getting image size: $e');
      return 'Unknown size';
    }
  }

  /// Format bytes to human readable format
  static String _formatBytes(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }

  /// Method to refresh/reload prescriptions
  static Future<List<UserPrescription>> refreshUserPrescriptions() async {
    print('Refreshing user prescriptions...');
    return await getUserPrescriptions();
  }

  /// Method to check if prescription image is accessible
  static Future<bool> isImageAccessible(String imageUrl) async {
    try {
      final response = await http.head(Uri.parse(imageUrl)).timeout(_timeout);
      return response.statusCode == 200;
    } catch (e) {
      print('Error checking image accessibility: $e');
      return false;
    }
  }
}