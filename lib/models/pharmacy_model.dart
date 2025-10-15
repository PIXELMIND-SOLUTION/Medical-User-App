// class PharmacyLocation {
//   final String type;
//   final List<double> coordinates;

//   PharmacyLocation({
//     required this.type,
//     required this.coordinates,
//   });

//   factory PharmacyLocation.fromJson(Map<String, dynamic> json) {
//     return PharmacyLocation(
//       type: json['type'] ?? '',
//       coordinates: List<double>.from(json['coordinates'] ?? []),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'type': type,
//       'coordinates': coordinates,
//     };
//   }
// }

// class PharmacyCategory {
//   final String name;
//   final String image;
//   final String id;

//   PharmacyCategory({
//     required this.name,
//     required this.image,
//     required this.id,
//   });

//   factory PharmacyCategory.fromJson(Map<String, dynamic> json) {
//     return PharmacyCategory(
//       name: json['name'] ?? '',
//       image: json['image'] ?? '',
//       id: json['_id'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'image': image,
//       '_id': id,
//     };
//   }
// }

// class Pharmacy {
//   final PharmacyLocation location;
//   final String id;
//   final String name;
//   final String image;
//   final double latitude;
//   final double longitude;
//   final String createdAt;
//   final String updatedAt;
//   final int version;
//   final List<PharmacyCategory> categories;
//   final List<dynamic> products; // You can create a Product model later if needed

//   Pharmacy({
//     required this.location,
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.latitude,
//     required this.longitude,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.version,
//     required this.categories,
//     required this.products,
//   });

//   factory Pharmacy.fromJson(Map<String, dynamic> json) {
//     return Pharmacy(
//       location: PharmacyLocation.fromJson(json['location'] ?? {}),
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       image: json['image'] ?? '',
//       latitude: (json['latitude'] ?? 0.0).toDouble(),
//       longitude: (json['longitude'] ?? 0.0).toDouble(),
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//       version: json['__v'] ?? 0,
//       categories: (json['categories'] as List<dynamic>? ?? [])
//           .map((category) => PharmacyCategory.fromJson(category))
//           .toList(),
//       products: json['products'] ?? [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'location': location.toJson(),
//       '_id': id,
//       'name': name,
//       'image': image,
//       'latitude': latitude,
//       'longitude': longitude,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       '__v': version,
//       'categories': categories.map((category) => category.toJson()).toList(),
//       'products': products,
//     };
//   }
// }

// class PharmacyResponse {
//   final String message;
//   final int total;
//   final List<Pharmacy> pharmacies;

//   PharmacyResponse({
//     required this.message,
//     required this.total,
//     required this.pharmacies,
//   });

//   factory PharmacyResponse.fromJson(Map<String, dynamic> json) {
//     return PharmacyResponse(
//       message: json['message'] ?? '',
//       total: json['total'] ?? 0,
//       pharmacies: (json['pharmacies'] as List<dynamic>? ?? [])
//           .map((pharmacy) => Pharmacy.fromJson(pharmacy))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'message': message,
//       'total': total,
//       'pharmacies': pharmacies.map((pharmacy) => pharmacy.toJson()).toList(),
//     };
//   }
// }














class PharmacyLocation {
  final String type;
  final List<double> coordinates;

  PharmacyLocation({
    required this.type,
    required this.coordinates,
  });

  factory PharmacyLocation.fromJson(Map<String, dynamic> json) {
    return PharmacyLocation(
      type: json['type'] ?? '',
      coordinates: List<double>.from(json['coordinates'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

class PharmacyCategory {
  final String name;
  final String image;
  final String id;

  PharmacyCategory({
    required this.name,
    required this.image,
    required this.id,
  });

  factory PharmacyCategory.fromJson(Map<String, dynamic> json) {
    return PharmacyCategory(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      '_id': id,
    };
  }
}

class Pharmacy {
  final PharmacyLocation location;
  final String id;
  final String name;
  final String image;
  final double latitude;
  final double longitude;
  final String address;
  final String createdAt;
  final String updatedAt;
  final int version;
  final List<PharmacyCategory> categories;
  final List<dynamic> products; // You can create a Product model later if needed

  Pharmacy({
    required this.location,
    required this.id,
    required this.name,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.categories,
    required this.products,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      location: PharmacyLocation.fromJson(json['location'] ?? {}),
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      address: json['address'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      version: json['__v'] ?? 0,
      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((category) => PharmacyCategory.fromJson(category))
          .toList(),
      products: json['products'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      '_id': id,
      'name': name,
      'image': image,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': version,
      'categories': categories.map((category) => category.toJson()).toList(),
      'products': products,
    };
  }
}

class PharmacyResponse {
  final String message;
  final int total;
  final List<Pharmacy> pharmacies;

  PharmacyResponse({
    required this.message,
    required this.total,
    required this.pharmacies,
  });

  factory PharmacyResponse.fromJson(Map<String, dynamic> json) {
    return PharmacyResponse(
      message: json['message'] ?? '',
      total: json['total'] ?? 0,
      pharmacies: (json['pharmacies'] as List<dynamic>? ?? [])
          .map((pharmacy) => Pharmacy.fromJson(pharmacy))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'total': total,
      'pharmacies': pharmacies.map((pharmacy) => pharmacy.toJson()).toList(),
    };
  }
}