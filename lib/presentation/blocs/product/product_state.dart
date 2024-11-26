import 'package:catalogue_project/domain/models/product_model.dart';

abstract class ProductState {}

class ProductsLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<ProductModel> products;
  ProductsLoaded({required this.products});
}

class ProductsError extends ProductState {
  final String message;
  ProductsError({required this.message});
}

