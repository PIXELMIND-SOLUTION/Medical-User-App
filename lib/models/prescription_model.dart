class UserPrescription {
  final String id;
  final String userId;
  final Pharmacy pharmacy;
  final String prescriptionUrl;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserPrescription({
    required this.id,
    required this.userId,
    required this.pharmacy,
    required this.prescriptionUrl,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserPrescription.fromJson(Map<String, dynamic> json) {
    return UserPrescription(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      pharmacy: Pharmacy.fromJson(json['pharmacyId'] ?? {}),
      prescriptionUrl: json['prescriptionUrl'] ?? '',
      notes: json['notes'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'pharmacyId': pharmacy.toJson(),
      'prescriptionUrl': prescriptionUrl,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Helper method to format date
  String get formattedDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  // Helper method to format time
  String get formattedTime {
    final hour = createdAt.hour.toString().padLeft(2, '0');
    final minute = createdAt.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Helper method to get relative time (e.g., "2 days ago")
  String get relativeTime {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }
}

class Pharmacy {
  final String id;
  final String name;
  final String? image;

  Pharmacy({
    required this.id,
    required this.name,
    this.image,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
    };
  }
}