// models/query_model.dart
class QueryModel {
  final String? id;
  final String name;
  final String email;
  final String mobile;
  final String message;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  QueryModel({
    this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.message,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory QueryModel.fromJson(Map<String, dynamic> json) {
    return QueryModel(
      id: json['_id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      message: json['message'] ?? '',
      status: json['status'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'mobile': mobile,
      'message': message,
    };
  }
}

class AddQueryResponse {
  final String message;
  final QueryModel query;

  AddQueryResponse({
    required this.message,
    required this.query,
  });

  factory AddQueryResponse.fromJson(Map<String, dynamic> json) {
    return AddQueryResponse(
      message: json['message'] ?? '',
      query: QueryModel.fromJson(json['query']),
    );
  }
}