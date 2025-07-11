class ServiceModel {
  final String id;
  final String servicesName;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  ServiceModel({
    required this.id,
    required this.servicesName,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  // Factory constructor to create ServiceModel from JSON
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'] ?? '',
      servicesName: json['servicesName'] ?? '',
      image: json['image'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'] ?? 0,
    );
  }

  // Method to convert ServiceModel to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'servicesName': servicesName,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }

  // CopyWith method for immutable updates
  ServiceModel copyWith({
    String? id,
    String? servicesName,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      servicesName: servicesName ?? this.servicesName,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }

  @override
  String toString() {
    return 'ServiceModel(id: $id, servicesName: $servicesName, image: $image, createdAt: $createdAt, updatedAt: $updatedAt, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ServiceModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Response wrapper class
class ServiceResponse {
  final String message;
  final int total;
  final List<ServiceModel> services;

  ServiceResponse({
    required this.message,
    required this.total,
    required this.services,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    return ServiceResponse(
      message: json['message'] ?? '',
      total: json['total'] ?? 0,
      services: (json['services'] as List<dynamic>?)
              ?.map((service) => ServiceModel.fromJson(service))
              .toList() ??
          [],
    );
  }
}