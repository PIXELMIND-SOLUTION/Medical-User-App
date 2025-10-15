// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:medical_user_app/constant/api_constants.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';

// class AddressService {
//   // Add new address
//   static Future<Map<String, dynamic>> addAddress({
//     required String userId,
//     required String house,
//     required String street,
//     required String city,
//     required String state,
//     required String pincode,
//     required String country,
//   }) async {
//     try {
//       final token = await SharedPreferencesHelper.getToken();
      
//       final url = ApiConstants.addAddress.replaceAll(':userId', userId);
      
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           if (token != null) 'Authorization': 'Bearer $token',
//         },
//         body: json.encode({
//           "house": house,
//           "street": street,
//           "city": city,
//           "state": state,
//           "pincode": pincode,
//           "country": country,
//         }),
//       );

//       final responseData = json.decode(response.body);


//       print('response status code ${response.statusCode}');
//          print('response bodyyyyy ${response.body}');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return {
//           'success': true,
//           'message': responseData['message'] ?? 'Address added successfully',
//           'data': responseData['data'],
//         };
//       } else {
//         return {
//           'success': false,
//           'message': responseData['message'] ?? 'Failed to add address',
//           'data': null,
//         };
//       }
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'Network error: ${e.toString()}',
//         'data': null,
//       };
//     }
//   }

//   // Get user addresses
//   static Future<Map<String, dynamic>> getUserAddresses(String userId) async {
//     try {
//       final token = await SharedPreferencesHelper.getToken();
      
//       final url = ApiConstants.getAddress.replaceAll(':userId', userId);
      
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           if (token != null) 'Authorization': 'Bearer $token',
//         },
//       );

//       final responseData = json.decode(response.body);


//        print('response status code ${response.statusCode}');
//          print('response bodyyyyy ${response.body}');

//       if (response.statusCode == 200) {
//         return {
//           'success': true,
//           'message': responseData['message'] ?? 'Addresses fetched successfully',
//           'data': responseData['data'] ?? responseData['addresses'] ?? [],
//         };
//       } else {
//         return {
//           'success': false,
//           'message': responseData['message'] ?? 'Failed to fetch addresses',
//           'data': [],
//         };
//       }
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'Network error: ${e.toString()}',
//         'data': [],
//       };
//     }
//   }
// }
















import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class AddressService {
  // Helper method to safely decode JSON response
  static Map<String, dynamic> _safeJsonDecode(String body, int statusCode) {
    try {
      // Check if response starts with HTML tags (common error responses)
      if (body.trim().toLowerCase().startsWith('<!doctype') || 
          body.trim().toLowerCase().startsWith('<html')) {
        print('Warning: Received HTML response instead of JSON');
        print('Response body: ${body.substring(0, body.length > 200 ? 200 : body.length)}...');
        
        return {
          'success': false,
          'message': 'Server returned HTML instead of JSON. Status code: $statusCode',
          'data': null,
        };
      }
      
      // Try to decode JSON
      return json.decode(body) as Map<String, dynamic>;
    } catch (e) {
      print('JSON decode error: $e');
      print('Response body: ${body.substring(0, body.length > 200 ? 200 : body.length)}...');
      
      return {
        'success': false,
        'message': 'Invalid JSON response from server',
        'data': null,
      };
    }
  }

  // Add new address
  static Future<Map<String, dynamic>> addAddress({
    required String userId,
    required String house,
    required String street,
    required String city,
    required String state,
    required String pincode,
    required String country,
  }) async {
    try {
      print('=== ADD ADDRESS REQUEST ===');
      print('User ID: $userId');
      
      final token = await SharedPreferencesHelper.getToken();
      print('Token available: ${token != null}');
      
      // Validate userId before making request
      if (userId.isEmpty) {
        print('Error: Empty user ID');
        return {
          'success': false,
          'message': 'User ID is required',
          'data': null,
        };
      }
      
      final url = ApiConstants.addAddress.replaceAll(':userId', userId);
      print('Request URL: $url');
      
      final requestBody = {
        "house": house,
        "street": street,
        "city": city,
        "state": state,
        "pincode": pincode,
        "country": country,
      };
      print('Request body: $requestBody');
      
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json', // Explicitly request JSON response
        if (token != null) 'Authorization': 'Bearer $token',
      };
      print('Request headers: $headers');
      
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(requestBody),
      );

      print('Response status code: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body length: ${response.body.length}');
      print('Response body preview: ${response.body.substring(0, response.body.length > 300 ? 300 : response.body.length)}');

      // Handle different status codes
      if (response.statusCode == 404) {
        return {
          'success': false,
          'message': 'API endpoint not found. Please check the URL configuration.',
          'data': null,
        };
      }
      
      if (response.statusCode == 401) {
        return {
          'success': false,
          'message': 'Unauthorized. Please login again.',
          'data': null,
        };
      }
      
      if (response.statusCode == 403) {
        return {
          'success': false,
          'message': 'Access forbidden. Check your permissions.',
          'data': null,
        };
      }

      final responseData = _safeJsonDecode(response.body, response.statusCode);
      
      // If JSON decode failed, return the error from _safeJsonDecode
      if (responseData['success'] == false && responseData['message'].toString().contains('JSON')) {
        return responseData;
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'Address added successfully',
          'data': responseData['data'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to add address (Status: ${response.statusCode})',
          'data': null,
        };
      }
    } catch (e, stackTrace) {
      print('=== ADD ADDRESS ERROR ===');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      print('=== END ERROR ===');
      
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'data': null,
      };
    }
  }

  // Get user addresses
  // static Future<Map<String, dynamic>> getUserAddresses(String userId) async {
  //   try {
  //     print('=== GET ADDRESSES REQUEST ===');
  //     print('User ID: $userId');
      
  //     final token = await SharedPreferencesHelper.getToken();
  //     print('Token available: ${token != null}');
      
  //     // Validate userId before making request
  //     if (userId.isEmpty) {
  //       print('Error: Empty user ID');
  //       return {
  //         'success': false,
  //         'message': 'User ID is required',
  //         'data': [],
  //       };
  //     }
      
  //     final url = ApiConstants.getAddress.replaceAll(':userId', userId);
  //     print('Request URL: $url');
      
  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json', // Explicitly request JSON response
  //       if (token != null) 'Authorization': 'Bearer $token',
  //     };
  //     print('Request headers: $headers');
      
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: headers,
  //     );

  //     print('Response status code: ${response.statusCode}');
  //     print('Response headers: ${response.headers}');
  //     print('Response body length: ${response.body.length}');
  //     print('Response body preview: ${response.body.substring(0, response.body.length > 300 ? 300 : response.body.length)}');

  //     // Handle different status codes
  //     if (response.statusCode == 404) {
  //       return {
  //         'success': false,
  //         'message': 'API endpoint not found. Please check the URL configuration.',
  //         'data': [],
  //       };
  //     }
      
  //     if (response.statusCode == 401) {
  //       return {
  //         'success': false,
  //         'message': 'Unauthorized. Please login again.',
  //         'data': [],
  //       };
  //     }
      
  //     if (response.statusCode == 403) {
  //       return {
  //         'success': false,
  //         'message': 'Access forbidden. Check your permissions.',
  //         'data': [],
  //       };
  //     }

  //     final responseData = _safeJsonDecode(response.body, response.statusCode);
      
  //     // If JSON decode failed, return the error from _safeJsonDecode
  //     if (responseData['success'] == false && responseData['message'].toString().contains('JSON')) {
  //       return {
  //         'success': false,
  //         'message': responseData['message'],
  //         'data': [],
  //       };
  //     }

  //     if (response.statusCode == 200) {
  //       return {
  //         'success': true,
  //         'message': responseData['message'] ?? 'Addresses fetched successfully',
  //         'data': responseData['data'] ?? responseData['addresses'] ?? [],
  //       };
  //     } else {
  //       return {
  //         'success': false,
  //         'message': responseData['message'] ?? 'Failed to fetch addresses (Status: ${response.statusCode})',
  //         'data': [],
  //       };
  //     }
  //   } catch (e, stackTrace) {
  //     print('=== GET ADDRESSES ERROR ===');
  //     print('Error: $e');
  //     print('Stack trace: $stackTrace');
  //     print('=== END ERROR ===');
      
  //     return {
  //       'success': false,
  //       'message': 'Network error: ${e.toString()}',
  //       'data': [],
  //     };
  //   }
  // }



    // Get user addresses - UPDATED METHOD
  static Future<Map<String, dynamic>> getUserAddresses(String userId) async {
    try {
      print('=== GET ADDRESSES REQUEST ===');
      print('User ID: $userId');
      
      final token = await SharedPreferencesHelper.getToken();
      print('Token available: ${token != null}');
      
      if (userId.isEmpty) {
        print('Error: Empty user ID');
        return {
          'success': false,
          'message': 'User ID is required',
          'data': [],
        };
      }
      
      final url = ApiConstants.getAddress.replaceAll(':userId', userId);
      print('Request URL: $url');
      
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };
      
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      final responseData = _safeJsonDecode(response.body, response.statusCode);
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'Addresses fetched successfully',
          // Updated to look for 'myAddresses' first, then fallback to other keys
          'data': responseData['myAddresses'] ?? responseData['data'] ?? responseData['addresses'] ?? [],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to fetch addresses (Status: ${response.statusCode})',
          'data': [],
        };
      }
    } catch (e, stackTrace) {
      print('=== GET ADDRESSES ERROR ===');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'data': [],
      };
    }
  }

  // Debug method to test API endpoint
  static Future<void> debugApiEndpoint(String userId) async {
    try {
      print('=== DEBUG API ENDPOINT ===');
      
      final token = await SharedPreferencesHelper.getToken();
      final url = ApiConstants.getAddress.replaceAll(':userId', userId);
      
      print('Testing URL: $url');
      print('Token: ${token != null ? 'Available' : 'Not available'}');
      
      // Test if URL is reachable
      final response = await http.head(Uri.parse(url));
      print('HEAD request status: ${response.statusCode}');
      print('HEAD request headers: ${response.headers}');
      
      print('=== END DEBUG ===');
    } catch (e) {
      print('Debug error: $e');
    }
  }
}