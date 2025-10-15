// models/notification_model.dart
class NotificationModel {
  final String id;
  final String orderId;
  final String status;
  final String message;
  final DateTime timestamp;
  final bool read;

  NotificationModel({
    required this.id,
    required this.orderId,
    required this.status,
    required this.message,
    required this.timestamp,
    required this.read,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? '',
      orderId: json['orderId'] ?? '',
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      read: json['read'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'orderId': orderId,
      'status': status,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'read': read,
    };
  }
}
