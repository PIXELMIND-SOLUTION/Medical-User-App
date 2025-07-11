// services/category_service.dart

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';

class CategoryService {
  static const String baseUrl = 'http://194.164.148.244:7021/api/category';
  
  // Timeout duration for HTTP requests
  static const Duration timeoutDuration = Duration(seconds: 30);

  /// Fetches categories from the API
  /// If serviceName is provided, only categories for that service will be fetched
  /// If serviceName is null or empty, all categories will be fetched
  Future<CategoryResponse> getAllCategories({String? serviceName}) async {
    try {
      Uri uri;

      print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh$serviceName");
      
      // Build URI based on whether serviceName is provided
      if (serviceName != null && serviceName.isNotEmpty) {
        uri = Uri.parse('$baseUrl/allcategories').replace(
          queryParameters: {'serviceName': serviceName.toLowerCase()},
        );
      } else {
        uri = Uri.parse('$baseUrl/allcategories');
      }

      print('pppppppppppppppppppppppppppppppppppppppppppppppp$uri');
      
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(timeoutDuration);

      print("ddddddddddddddddddddddddddddddddddddddddddddddd${response.body}");

     final Map<String, dynamic> jsonData = json.decode(response.body);
          return CategoryResponse.fromJson(jsonData);
    } catch (e) {
      throw CategoryException('Failed to fetch categories: ${e.toString()}');
    }
  }
}







//   /// Fetches categories by service name
//   /// This is a more explicit method for getting categories by service
//   Future<CategoryResponse> getCategoriesByService(String serviceName) async {
//     return await getAllCategories(serviceName: serviceName);
//   }

//   /// Handles HTTP response and parses JSON
//   CategoryResponse _handleResponse(http.Response response) {
//     switch (response.statusCode) {
//       case 200:
//         try {
//           final Map<String, dynamic> jsonData = json.decode(response.body);
//           return CategoryResponse.fromJson(jsonData);
//         } catch (e) {
//           throw CategoryException('Failed to parse server response');
//         }
//       case 400:
//         throw CategoryException('Bad request. Please check your input.');
//       case 401:
//         throw CategoryException('Unauthorized. Please login again.');
//       case 403:
//         throw CategoryException('Access forbidden. You don\'t have permission.');
//       case 404:
//         throw CategoryException('Categories not found.');
//       case 500:
//         throw CategoryException('Server error. Please try again later.');
//       default:
//         throw CategoryException(
//           'Request failed with status: ${response.statusCode}. ${response.body}',
//         );
//     }
//   }

//   /// Get category by ID (if your API supports it)
//   Future<Category?> getCategoryById(String categoryId) async {
//     try {
//       final uri = Uri.parse('$baseUrl/$categoryId');
      
//       final response = await http.get(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//       ).timeout(timeoutDuration);

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonData = json.decode(response.body);
//         return Category.fromJson(jsonData);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       throw CategoryException('Failed to fetch category: ${e.toString()}');
//     }
//   }

//   /// Search categories by name (if your API supports it)
//   /// Can also filter by service if serviceName is provided
//   Future<List<Category>> searchCategories(String query, {String? serviceName}) async {
//     try {
//       Map<String, String> queryParams = {'q': query};
      
//       // Add service filter if provided
//       if (serviceName != null && serviceName.isNotEmpty) {
//         queryParams['serviceName'] = serviceName;
//       }
      
//       final uri = Uri.parse('$baseUrl/search').replace(
//         queryParameters: queryParams,
//       );
      
//       final response = await http.get(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//       ).timeout(timeoutDuration);

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonData = json.decode(response.body);
//         final CategoryResponse categoryResponse = CategoryResponse.fromJson(jsonData);
//         return categoryResponse.categories;
//       } else {
//         return [];
//       }
//     } catch (e) {
//       throw CategoryException('Failed to search categories: ${e.toString()}');
//     }
//   }

//   /// Get all unique service names (if your API supports it)
//   Future<List<String>> getAllServiceNames() async {
//     try {
//       final uri = Uri.parse('$baseUrl/services');
      
//       final response = await http.get(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//       ).timeout(timeoutDuration);

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(response.body);
//         return jsonData.cast<String>();
//       } else {
//         return [];
//       }
//     } catch (e) {
//       throw CategoryException('Failed to fetch service names: ${e.toString()}');
//     }
//   }
// }

// /// Custom exception class for category-related errors
class CategoryException implements Exception {
  final String message;
  
  CategoryException(this.message);
  
  @override
  String toString() => 'CategoryException: $message';
}