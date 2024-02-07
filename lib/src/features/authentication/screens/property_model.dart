class Property {
  final String propertyType;
  final String price;
  final String bedrooms;
  final String bathrooms;
  final String district;
  final String area;
  final String phone;
  final String facilities;
  final String imageUrl;
  final String availableDate;
  bool isFavorite;

  Property({
    required this.propertyType,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.district,
    required this.area,
    required this.phone,
    required this.facilities,
    required this.imageUrl,
    required this.availableDate,
    this.isFavorite = false,
  });

  factory Property.fromDocument(Map<String, dynamic> data) {
    return Property(
      propertyType: data['propertyType'] ?? '',
      price: data['price'] ?? '',
      bedrooms: data['bedrooms'] ?? '',
      bathrooms: data['bathrooms'] ?? '',
      district: data['district'] ?? '',
      area: data['area'] ?? '',
      phone: data['phone'] ?? '',
      facilities: data['facilities'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      availableDate: data['availableDate'] ?? '',
      isFavorite: data['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'propertyType': propertyType,
      'price': price,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'district': district,
      'area': area,
      'phone': phone,
      'facilities': facilities,
      'imageUrl': imageUrl,
      'availableDate': availableDate,
      'isFavorite': isFavorite,
    };
  }
}

