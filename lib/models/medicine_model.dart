class MedicineModel {
  final String id;
  final String name;
  final List<String> images;
  final int price;
  final String description;

  MedicineModel({
    required this.id,
    required this.name,
    required this.images,
    required this.price,
    required this.description,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['medicineId'],
      name: json['name'],
      images: List<String>.from(json['images']),
      price: json['price'],
      description: json['description'],
    );
  }
}
