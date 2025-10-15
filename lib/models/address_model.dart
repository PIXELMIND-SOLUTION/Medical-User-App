class Address {
  final String? id;
  final String house;
  final String street;
  final String city;
  final String state;
  final String pincode;
  final String country;

  Address({
    this.id,
    required this.house,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
  });

  // Convert to JSON for API calls
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'house': house,
      'street': street,
      'city': city,
      'state': state,
      'pincode': pincode,
      'country': country,
    };
  }

  // Create from JSON response
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['_id'] ?? json['id'],
      house: json['house'] ?? '',
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      pincode: json['pincode'] ?? '',
      country: json['country'] ?? '',
    );
  }

  // Create a copy with updated fields
  Address copyWith({
    String? id,
    String? house,
    String? street,
    String? city,
    String? state,
    String? pincode,
    String? country,
  }) {
    return Address(
      id: id ?? this.id,
      house: house ?? this.house,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      country: country ?? this.country,
    );
  }

  @override
  String toString() {
    return '$house, $street, $city, $state - $pincode, $country';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Address &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          house == other.house &&
          street == other.street &&
          city == other.city &&
          state == other.state &&
          pincode == other.pincode &&
          country == other.country;

  @override
  int get hashCode =>
      id.hashCode ^
      house.hashCode ^
      street.hashCode ^
      city.hashCode ^
      state.hashCode ^
      pincode.hashCode ^
      country.hashCode;
}