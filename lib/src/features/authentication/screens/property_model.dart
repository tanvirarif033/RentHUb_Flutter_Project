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
    );
  }
}