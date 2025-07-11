// models/category_model.dart

class CategoryResponse {
  final String message;
  final int total;
  final List<Category> categories;

  CategoryResponse({
    required this.message,
    required this.total,
    required this.categories,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      message: json['message'] ?? '',
      total: json['total'] ?? 0,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((item) => Category.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'total': total,
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }
}

class Category {
  final String id;
  final String categoryName;
  final String image;
  final String serviceName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  Category({
    required this.id,
    required this.categoryName,
    required this.image,
    required this.serviceName,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      categoryName: json['categoryName'] ?? '',
      image: json['image'] ?? '',
      serviceName: json['serviceName'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      version: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'categoryName': categoryName,
      'image': image,
      'serviceName': serviceName,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }

  @override
  String toString() {
    return 'Category{id: $id, categoryName: $categoryName, serviceName: $serviceName}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}