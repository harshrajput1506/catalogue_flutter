import 'package:catalogue_project/domain/models/product_category_model.dart';
import 'package:catalogue_project/domain/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts(int page);
  Future<List<ProductCategoryModel>> getProductCategories();
  Future<List<ProductModel>> getProductsByCategory(String url);
}