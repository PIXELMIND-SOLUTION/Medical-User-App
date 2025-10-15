// Medicine Model
class Medicine {
  final String id;
  final String pharmacyId;
  final String name;
  final List<String> images;
  final double price;
  final double mrp;
  final String description;
  final String categoryName;
  final String createdAt;
  final String updatedAt;
  final int version;

  Medicine({
    required this.id,
    required this.pharmacyId,
    required this.name,
    required this.images,
    required this.price,
    required this.mrp,
    required this.description,
    required this.categoryName,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['_id'] ?? '',
      pharmacyId: json['pharmacyId'] ?? '',
      name: json['name'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      price: (json['price'] ?? 0.0).toDouble(),
      mrp: (json['mrp'] ?? 0.0).toDouble(),
      description: json['description'] ?? '',
      categoryName: json['categoryName'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      version: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'pharmacyId': pharmacyId,
      'name': name,
      'images': images,
      'price': price,
      'mrp': mrp,
      'description': description,
      'categoryName': categoryName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': version,
    };
  }

  // Calculate discount percentage
  double get discountPercentage {
    if (mrp <= 0) return 0;
    return ((mrp - price) / mrp) * 100;
  }

  // Get savings amount
  double get savings => mrp - price;
}

// Pharmacy Info Model (simplified version for medicine response)
class PharmacyInfo {
  final String id;
  final String name;
  final String address;
  final String image;

  PharmacyInfo({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
  });

  factory PharmacyInfo.fromJson(Map<String, dynamic> json) {
    return PharmacyInfo(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'address': address,
      'image': image,
    };
  }
}

// Pharmacy Medicines Response Model
class PharmacyMedicinesResponse {
  final String message;
  final PharmacyInfo pharmacy;
  final String categoryFilter;
  final int totalMedicines;
  final List<Medicine> medicines;

  PharmacyMedicinesResponse({
    required this.message,
    required this.pharmacy,
    required this.categoryFilter,
    required this.totalMedicines,
    required this.medicines,
  });

  factory PharmacyMedicinesResponse.fromJson(Map<String, dynamic> json) {
    return PharmacyMedicinesResponse(
      message: json['message'] ?? '',
      pharmacy: PharmacyInfo.fromJson(json['pharmacy'] ?? {}),
      categoryFilter: json['categoryFilter'] ?? '',
      totalMedicines: json['totalMedicines'] ?? 0,
      medicines: (json['medicines'] as List<dynamic>? ?? [])
          .map((medicine) => Medicine.fromJson(medicine))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'pharmacy': pharmacy.toJson(),
      'categoryFilter': categoryFilter,
      'totalMedicines': totalMedicines,
      'medicines': medicines.map((medicine) => medicine.toJson()).toList(),
    };
  }
}