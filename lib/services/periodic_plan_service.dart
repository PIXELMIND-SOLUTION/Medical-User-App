// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:medical_user_app/constant/api_constants.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';

// class PeriodicPlanService {
//   static Future<Map<String, dynamic>> createPeriodicPlan({
//     required String userId,
//     required String planType,
//     required List<Map<String, dynamic>> orderItems,
//     required List<String> deliveryDates,
//     String? notes,
//     String? voiceNoteUrl,
//   }) async {
//     try {
//       // Get auth token
//       final token = await SharedPreferencesHelper.getToken();
//       if (token == null) {
//         return {
//           'success': false,
//           'message': 'Authentication token not found',
//         };
//       }

//       // Prepare the request URL
//       final url = ApiConstants.perioidicplan.replaceAll(':userId', userId);
      
//       // Prepare the request body
//       final requestBody = {
//         'planType': planType,
//         'orderItems': orderItems,
//         'deliveryDates': deliveryDates,
//         'notes': notes ?? '',
//         'voiceNoteUrl': voiceNoteUrl ?? '',
//       };

//       print('Creating periodic plan with data: ${json.encode(requestBody)}');

//       // Make the HTTP request
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: json.encode(requestBody),
//       );

//       print('Periodic plan response status: ${response.statusCode}');
//       print('Periodic plan response body: ${response.body}');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final responseData = json.decode(response.body);
//         return {
//           'success': true,
//           'message': responseData['message'] ?? 'Periodic plan created successfully',
//           'data': responseData,
//         };
//       } else {
//         final errorData = json.decode(response.body);
//         return {
//           'success': false,
//           'message': errorData['message'] ?? 'Failed to create periodic plan',
//           'error': errorData,
//         };
//       }
//     } catch (e) {
//       print('Error creating periodic plan: $e');
//       return {
//         'success': false,
//         'message': 'Network error: ${e.toString()}',
//       };
//     }
//   }

//   static Future<Map<String, dynamic>> getUserPeriodicPlans(String userId) async {
//     try {
//       final token = await SharedPreferencesHelper.getToken();
//       if (token == null) {
//         return {
//           'success': false,
//           'message': 'Authentication token not found',
//         };
//       }

//       final url = ApiConstants.perioidicplan.replaceAll(':userId', userId);

//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       print('Get periodic plans response status: ${response.statusCode}');
//       print('Get periodic plans response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         return {
//           'success': true,
//           'data': responseData,
//         };
//       } else {
//         final errorData = json.decode(response.body);
//         return {
//           'success': false,
//           'message': errorData['message'] ?? 'Failed to get periodic plans',
//         };
//       }
//     } catch (e) {
//       print('Error getting periodic plans: $e');
//       return {
//         'success': false,
//         'message': 'Network error: ${e.toString()}',
//       };
//     }
//   }
// }















import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class PeriodicPlanService {
  static Future<Map<String, dynamic>> createPeriodicPlan({
    required String userId,
    required String planType,
    required List<Map<String, dynamic>> orderItems,
    required List<String> deliveryDates,
    String? notes,
    String? voiceNoteUrl,
    double? totalAmount, // Add total amount parameter
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

      // Prepare the request URL
      final url = ApiConstants.perioidicplan.replaceAll(':userId', userId);
      
      // Calculate totals if not provided
      double calculatedTotal = totalAmount ?? 0.0;
      if (calculatedTotal == 0.0) {
        for (var item in orderItems) {
          double itemPrice = (item['price'] ?? 0.0).toDouble();
          int itemQuantity = (item['quantity'] ?? 1).toInt();
          calculatedTotal += itemPrice * itemQuantity;
        }
      }
      
      // Prepare the request body with enhanced data
      final requestBody = {
        'planType': planType,
        'orderItems': orderItems,
        'deliveryDates': deliveryDates,
        'notes': notes ?? '',
        'voiceNoteUrl': voiceNoteUrl ?? '',
        'subtotal': calculatedTotal, // Add subtotal
        'total': calculatedTotal, // Add total (assuming no additional charges)
        'currency': 'INR', // Add currency
        'status': 'pending', // Add initial status
      };

      print('Creating periodic plan with data: ${json.encode(requestBody)}');

      // Make the HTTP request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );

      print('Periodic plan response statussssssss: ${response.statusCode}');
      print('Periodic plan response bodyyyyyyyyyyyy: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        return {
          'success': true,
          'message': responseData['message'] ?? 'Periodic plan created successfully',
          'data': responseData,
        };
      } else {
        final errorData = json.decode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Failed to create periodic plan',
          'error': errorData,
        };
      }
    } catch (e) {
      print('Error creating periodic plan: $e');
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
      };
    }
  }

  // static Future<Map<String, dynamic>> getUserPeriodicPlans(String userId) async {
  //   try {
  //     final token = await SharedPreferencesHelper.getToken();
  //     if (token == null) {
  //       return {
  //         'success': false,
  //         'message': 'Authentication token not found',
  //       };
  //     }

  //     final url = ApiConstants.perioidicplan.replaceAll(':userId', userId);

  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     print('Get periodic plans response statusssssssssssssss: ${response.statusCode}');
  //     print('Get periodic plans response bodyyyyyyyyyyyyyyyyyyy: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       return {
  //         'success': true,
  //         'data': responseData,
  //       };
  //     } else {
  //       final errorData = json.decode(response.body);
  //       return {
  //         'success': false,
  //         'message': errorData['message'] ?? 'Failed to get periodic plans',
  //       };
  //     }
  //   } catch (e) {
  //     print('Error getting periodic plans: $e');
  //     return {
  //       'success': false,
  //       'message': 'Network error: ${e.toString()}',
  //     };
  //   }
  // }

  // Additional method to validate medicine data before sending
  static bool validateOrderItems(List<Map<String, dynamic>> orderItems) {
    if (orderItems.isEmpty) return false;
    
    for (var item in orderItems) {
      if (item['medicineId'] == null || 
          item['quantity'] == null || 
          item['quantity'] <= 0) {
        return false;
      }
    }
    return true;
  }
}