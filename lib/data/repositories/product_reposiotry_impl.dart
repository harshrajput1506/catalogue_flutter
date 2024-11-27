import 'dart:convert';

import 'package:catalogue_project/core/constants.dart';
import 'package:catalogue_project/domain/models/product_category_model.dart';
import 'package:catalogue_project/domain/models/product_model.dart';
import 'package:catalogue_project/domain/repositories/product_repository.dart';
import 'package:http/http.dart' as http;

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<List<ProductModel>> getProducts(int page) async {
    try {
      Uri uri = Uri.parse('$baseUrl?limit=20&skip=${page * 20}');
      final response = await http.get(uri);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        List<ProductModel> list = (data['products'] as List).map((product) => ProductModel.fromJson(product)).toList();
        return list;
      } else {
        throw Exception('Server error, code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: ${e.toString()}'); 
    }
  }

  @override
  Future<List<ProductCategoryModel>> getProductCategories() async {
    try{
      final response = await http.get(Uri.parse("$baseUrl/categories"));
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        List<ProductCategoryModel> list = (data as List).map( (category) => ProductCategoryModel.fromJson(category)).toList();
        return list;
      } else {
        throw Exception('Server error, code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch categories : ${e.toString()}');
    }
  }
}