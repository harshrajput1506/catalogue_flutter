import 'package:catalogue_project/domain/models/product_model.dart';

abstract class ProductRepository {
  Future<ProductModel> getProducts();
}