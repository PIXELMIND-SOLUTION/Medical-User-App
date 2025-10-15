import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/models/user_model.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class ProfileService {
  
  // Get user profile
  static Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {

      print('userrrrrrrrrrrrrrrrrrrrrrrrrrrrid$userId');
      final url = ApiConstants.getuserProfile.replaceAll(':userId', userId);
      final token = await SharedPreferencesHelper.getToken();
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      print('Get Profile Response: ${response.statusCode}');
      print('Get Profile Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Profile retrieved successfully',
          'user': data['user'],
        };
      } else {
        final errorData = json.decode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Failed to get profile',
        };
      }
    } catch (e) {
      print('Error getting user profile: $e');
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
      };
    }
  }

  // Update user profile image
  static Future<Map<String, dynamic>> updateProfileImage(String userId, File imageFile) async {
    try {
      final url = ApiConstants.updateProfileImage.replaceAll(':userId', userId);
      final token = await SharedPreferencesHelper.getToken();
      
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      
      // Add headers
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      
      // Add file
      request.files.add(
        await http.MultipartFile.fromPath(
          'profileImage',
          imageFile.path,
        ),
      );

      print('Updating profile image for user: $userId');
      
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Update Profile Image Response: ${response.statusCode}');
      print('Update Profile Image Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Profile image updated successfully',
          'user': data['user'],
        };
      } else {
        final errorData = json.decode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Failed to update profile image',
        };
      }
    } catch (e) {
      print('Error updating profile image: $e');
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
      };
    }
  }

  // Update user data (name, mobile)
  static Future<Map<String, dynamic>> updateUserData(String userId, String name, String mobile) async {
    try {
      final url = ApiConstants.updateUserdata.replaceAll(':userId', userId);
      final token = await SharedPreferencesHelper.getToken();
      
      final requestBody = {
        'name': name,
        'mobile': mobile,
      };

      print('Updating user data: $requestBody');
      
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );

      print('Update User Data Response: ${response.statusCode}');
      print('Update User Data Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'User data updated successfully',
          'user': data['user'],
        };
      } else {
        final errorData = json.decode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Failed to update user data',
        };
      }
    } catch (e) {
      print('Error updating user data: $e');
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
      };
    }
  }

  // Comprehensive update method that updates both profile data and image
  static Future<Map<String, dynamic>> updateCompleteProfile({
    required String userId,
    required String name,
    required String mobile,
    File? profileImage,
  }) async {
    try {
      // First update user data
      final userDataResult = await updateUserData(userId, name, mobile);
      
      if (!userDataResult['success']) {
        return userDataResult;
      }

      // If profile image is provided, update it
      if (profileImage != null) {
        final imageResult = await updateProfileImage(userId, profileImage);
        
        if (!imageResult['success']) {
          return {
            'success': false,
            'message': 'User data updated but failed to update profile image: ${imageResult['message']}',
          };
        }
        
        return imageResult; // Return the final result with updated image
      }

      return userDataResult; // Return user data result if no image update
    } catch (e) {
      print('Error in complete profile update: $e');
      return {
        'success': false,
        'message': 'Error updating profile: ${e.toString()}',
      };
    }
  }
}