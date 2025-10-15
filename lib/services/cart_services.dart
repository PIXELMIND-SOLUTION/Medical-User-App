// services/cart_services.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/models/cart_model.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class CartServices {
  // Add item to cart
  static Future<Map<String, dynamic>> addToCart({
    required String medicineId,
    bool increment = true,
    bool decrement=true
  }) async {
    try {
      print('=== ADD TO CART SERVICE ===');
      
      // Get user from SharedPreferences
      final user = await SharedPreferencesHelper.getUser();
      if (user == null || user.id.isEmpty) {
        return {
          'success': false,
          'message': 'User not found. Please login again.',
          'data': null,
        };
      }

      // Get auth token
      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        return {
          'success': false,
          'message': 'Authentication token not found. Please login again.',
          'data': null,
        };
      }

      // Replace userId in URL
      final url = ApiConstants.addtoCart.replaceAll(':userId', user.id);
      print('Add to cart URL: $url');

      // Prepare payload
      final payload = {
        'medicineId': medicineId,
        'inc': increment,
        'dec':decrement
      };
      print('Payload: $payload');

      // Make API call
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(payload),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Item added to cart successfully',
          'data': data,
        };
      } else {
        final errorData = json.decode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Failed to add item to cart',
          'data': null,
        };
      }
    } catch (e) {
      print('Error in addToCart: $e');
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'data': null,
      };
    }
  }




  static Future<Map<String, dynamic>> addToCarts({
    required String medicineId,
    bool decrement=true
  }) async {
    try {
      print('=== ADD TO CART SERVICE ===');
      
      // Get user from SharedPreferences
      final user = await SharedPreferencesHelper.getUser();
      if (user == null || user.id.isEmpty) {
        return {
          'success': false,
          'message': 'User not found. Please login again.',
          'data': null,
        };
      }

      // Get auth token
      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        return {
          'success': false,
          'message': 'Authentication token not found. Please login again.',
          'data': null,
        };
      }

      // Replace userId in URL
      final url = ApiConstants.addtoCart.replaceAll(':userId', user.id);
      print('Add to cart URL: $url');

      // Prepare payload
      final payload = {
        'medicineId': medicineId,
        'dec':decrement
      };
      print('Payload: $payload');

      // Make API call
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(payload),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Item added to cart successfully',
          'data': data,
        };
      } else {
        final errorData = json.decode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Failed to add item to cart',
          'data': null,
        };
      }
    } catch (e) {
      print('Error in addToCart: $e');
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'data': null,
      };
    }
  }

  // Get cart items
  static Future<Map<String, dynamic>> getCart() async {
    try {
      print('=== GET CART SERVICE ===');
      
      // Get user from SharedPreferences
      final user = await SharedPreferencesHelper.getUser();
      if (user == null || user.id.isEmpty) {
        return {
          'success': false,
          'message': 'User not found. Please login again.',
          'data': CartModel.empty(),
        };
      }

      // Get auth token
      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        return {
          'success': false,
          'message': 'Authentication token not found. Please login again.',
          'data': CartModel.empty(),
        };
      }

      // Replace userId in URL
      final url = ApiConstants.getCart.replaceAll(':userId', user.id);
      print('Get cart URL: $url');

      // Make API call
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final cartData = data['cart'] ?? {};
        final cart = CartModel.fromJson(cartData);
        
        return {
          'success': true,
          'message': data['message'] ?? 'Cart fetched successfully',
          'data': cart,
        };
      } else {
        final errorData = json.decode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Failed to fetch cart',
          'data': CartModel.empty(),
        };
      }
    } catch (e) {
      print('Error in getCart: $e');
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'data': CartModel.empty(),
      };
    }
  }

  // Remove item from cart
  static Future<Map<String, dynamic>> removeFromCart({
    required String medicineId,
  }) async {
    try {
      print('=== REMOVE FROM CART SERVICE ===');
      
      // Get user from SharedPreferences
      final user = await SharedPreferencesHelper.getUser();
      if (user == null || user.id.isEmpty) {
        return {
          'success': false,
          'message': 'User not found. Please login again.',
          'data': null,
        };
      }

      // Get auth token
      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        return {
          'success': false,
          'message': 'Authentication token not found. Please login again.',
          'data': null,
        };
      }

      // Replace userId and medicineId in URL
      final url = ApiConstants.removeCart
          .replaceAll(':userId', user.id)
          .replaceAll(':medicineId', medicineId);
      print('Remove from cart URL: $url');

      // Make API call
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'message': data['message'] ?? 'Item removed from cart successfully',
          'data': data,
        };
      } else {
        final errorData = json.decode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Failed to remove item from cart',
          'data': null,
        };
      }
    } catch (e) {
      print('Error in removeFromCart: $e');
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'data': null,
      };
    }
  }

  // Decrease item quantity (add with inc: false)
  static Future<Map<String, dynamic>> decreaseQuantity({
    required String medicineId,
  }) async {
    return await addToCarts(medicineId: medicineId, decrement: true);
  }

  // Increase item quantity (add with inc: true)
  static Future<Map<String, dynamic>> increaseQuantity({
    required String medicineId,
  }) async {
    return await addToCart(medicineId: medicineId, increment: true);
  }
}