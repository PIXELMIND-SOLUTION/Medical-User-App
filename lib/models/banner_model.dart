class BannerModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final bool isActive;
  final String? buttonText;
  final String? actionUrl;
  final int? order;

  BannerModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.isActive,
    this.buttonText,
    this.actionUrl,
    this.order,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? json['image']?.toString() ?? '',
      isActive: json['isActive'] ?? json['active'] ?? true,
      buttonText: json['buttonText']?.toString(),
      actionUrl: json['actionUrl']?.toString() ?? json['link']?.toString(),
      order: json['order']?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'isActive': isActive,
      'buttonText': buttonText,
      'actionUrl': actionUrl,
      'order': order,
    };
  }
}