class ProductModel {

  int? id;
  String? title;
  String? description;
  String? image;
  String? thumbnail;
  double? price;
  double? discountPercentage;
  double? rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.thumbnail,
    required this.price,
    required this.discountPercentage,
    required this.rating
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'], 
      description: json['description'], 
      image: json['images'], 
      thumbnail: json['thumbnail'], 
      price: json['price'],
      discountPercentage: json['discountPercentage'], 
      rating: json['rating']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tite': title,
      'description': description, 
      'images': image, 
      'thumbnail': thumbnail, 
      'price': price,
      'discountPercentage': discountPercentage, 
      'rating': rating
    };
  }

} 