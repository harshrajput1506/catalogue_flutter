import 'package:catalogue_project/domain/models/product_category_model.dart';
import 'package:catalogue_project/domain/models/product_model.dart';

abstract class ProductState {}

class ProductsInitialize extends ProductState {}

class ProductsLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<ProductModel> products;
  ProductsLoaded({required this.products});
}

class ProductsError extends ProductState {
  final String message;
  ProductsError({required this.message});
}

class ProductCategoriesLoading extends ProductState {}

class ProductCategoriesLoaded extends ProductState{
  final List<ProductCategoryModel> categories;
  ProductCategoriesLoaded({required this.categories});
}

class ProductCategoriesError extends ProductState{
  final String message;
  ProductCategoriesError({required this.message});
}

// class SelectedProductCategory extends ProductState {
//   final int index;
//   SelectedProductCategory({required this.index});
// }


