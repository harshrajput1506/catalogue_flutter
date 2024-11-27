class ProductCategoryModel {
  String? name;
  String? url;

  ProductCategoryModel({
    required this.name,
    required this.url
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json){
    return ProductCategoryModel(name: json['name'], url: json['url']);
  }

}