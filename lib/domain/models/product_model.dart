class ProductModel {
  int? id;
  String? title;
  String? description;
  List<String>? images;
  String? thumbnail;
  String? brand;
  double? price;
  double? discountPercentage;
  double? rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.thumbnail,
    required this.price,
    required this.brand,
    required this.discountPercentage,
    required this.rating,
  });

  double get discountedPrice => ((price ?? 0) * (1 - (discountPercentage ?? 0) / 100));

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      images: (json['images'] as List<dynamic>).map((e) => e.toString()).toList(),
      thumbnail: json['thumbnail'],
      price: _toDouble(json['price']),
      brand: json['brand'],
      discountPercentage: _toDouble(json['discountPercentage']),
      rating: _toDouble(json['rating']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'images': images,
      'thumbnail': thumbnail,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'brand': brand,
    };
  }

  // Helper method to convert dynamic to double
  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
