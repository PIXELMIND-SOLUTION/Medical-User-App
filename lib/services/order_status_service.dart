import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';

import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class OrderStatusService {
  // Get order status timeline for a specific user
  static Future<Map<String, dynamic>?> getOrderStatus(String userId) async {
    try {
      // Get auth token from shared preferences
      final token = await SharedPreferencesHelper.getToken();
      if (token == null) {
        print('No auth token found');
        return null;
      }

      // Replace :userId with actual userId in the URL
      final url = ApiConstants.orderstatus.replaceAll(':userId', userId);
      print('Fetching order status from: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Order status response status: ${response.statusCode}');
      print('Order status response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 401) {
        print('Unauthorized: Token may be expired');
        return null;
      } else {
        print('Failed to fetch order status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching order status: $e');
      return null;
    }
  }

  // Get order status with error handling and parsed response
  static Future<OrderStatusResponse?> getOrderStatusParsed(String userId) async {
    try {
      final response = await getOrderStatus(userId);
      if (response != null) {
        return OrderStatusResponse.fromJson(response);
      }
      return null;
    } catch (e) {
      print('Error parsing order status response: $e');
      return null;
    }
  }

  // Check if user has any active orders
  static Future<bool> hasActiveOrders(String userId) async {
    try {
      final response = await getOrderStatusParsed(userId);
      if (response != null && response.statusTimeline.isNotEmpty) {
        // Check if the latest status indicates an active order
        final latestStatus = response.statusTimeline.last.status.toLowerCase();
        return !['delivered', 'cancelled', 'completed'].contains(latestStatus);
      }
      return false;
    } catch (e) {
      print('Error checking active orders: $e');
      return false;
    }
  }

  // Get current order status (latest status)
  static Future<String?> getCurrentOrderStatus(String userId) async {
    try {
      final response = await getOrderStatusParsed(userId);
      if (response != null && response.statusTimeline.isNotEmpty) {
        return response.statusTimeline.last.status;
      }
      return null;
    } catch (e) {
      print('Error getting current order status: $e');
      return null;
    }
  }
}

// Model classes for order status response
class OrderStatusResponse {
  final String message;
  final List<StatusTimeline> statusTimeline;
  final String? deliveryNote;
  final List<OrderMedicine> medicines;

  OrderStatusResponse({
    required this.message,
    required this.statusTimeline,
    this.deliveryNote,
    required this.medicines,
  });

  factory OrderStatusResponse.fromJson(Map<String, dynamic> json) {
    return OrderStatusResponse(
      message: json['message'] ?? '',
      statusTimeline: (json['statusTimeline'] as List<dynamic>?)
              ?.map((item) => StatusTimeline.fromJson(item))
              .toList() ??
          [],
      deliveryNote: json['deliveryNote'],
      medicines: (json['medicines'] as List<dynamic>?)
              ?.map((item) => OrderMedicine.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'statusTimeline': statusTimeline.map((item) => item.toJson()).toList(),
      'deliveryNote': deliveryNote,
      'medicines': medicines.map((item) => item.toJson()).toList(),
    };
  }
}

class StatusTimeline {
  final String status;
  final String message;
  final String timestamp;
  final String id;

  StatusTimeline({
    required this.status,
    required this.message,
    required this.timestamp,
    required this.id,
  });

  factory StatusTimeline.fromJson(Map<String, dynamic> json) {
    return StatusTimeline(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? '',
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'timestamp': timestamp,
      '_id': id,
    };
  }

  // Helper method to get formatted date
  DateTime? get parsedTimestamp {
    try {
      return DateTime.parse(timestamp);
    } catch (e) {
      print('Error parsing timestamp: $e');
      return null;
    }
  }

  // Helper method to check if this is the latest status
  bool isLatestIn(List<StatusTimeline> timeline) {
    if (timeline.isEmpty) return false;
    final sortedTimeline = List<StatusTimeline>.from(timeline);
    sortedTimeline.sort((a, b) {
      final aTime = a.parsedTimestamp;
      final bTime = b.parsedTimestamp;
      if (aTime == null || bTime == null) return 0;
      return bTime.compareTo(aTime);
    });
    return sortedTimeline.first.id == id;
  }
}

class OrderMedicine {
  final String name;
  final int mrp;
  final String description;
  final List<String> images;
  final int quantity;

  OrderMedicine({
    required this.name,
    required this.mrp,
    required this.description,
    required this.images,
    required this.quantity,
  });

  factory OrderMedicine.fromJson(Map<String, dynamic> json) {
    return OrderMedicine(
      name: json['name'] ?? '',
      mrp: json['mrp'] ?? 0,
      description: json['description'] ?? '',
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
      quantity: json['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mrp': mrp,
      'description': description,
      'images': images,
      'quantity': quantity,
    };
  }

  // Helper method to get total price
  int get totalPrice => mrp * quantity;

  // Helper method to get first image
  String? get firstImage => images.isNotEmpty ? images.first : null;
}