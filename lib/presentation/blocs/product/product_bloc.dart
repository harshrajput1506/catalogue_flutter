import 'dart:async';

import 'package:catalogue_project/core/constants.dart';
import 'package:catalogue_project/domain/models/product_category_model.dart';
import 'package:catalogue_project/domain/models/product_model.dart';
import 'package:catalogue_project/domain/repositories/product_repository.dart';
import 'package:catalogue_project/presentation/blocs/product/product_event.dart';
import 'package:catalogue_project/presentation/blocs/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepo;

  int page = 1;
  bool isFetchingMore = false;

  List<ProductModel> _products = [];

  ProductBloc({required this.productRepo}) : super(ProductsLoading()) {
    on<FetchProductDataEvent>(_onFetchProductDataEvent);
    on<FetchMorePorductsEvent>(_onFetchMoreProductsEvent);
    on<FetchProductsByCategory>(_onFetchProductsByCategory);
    on<FilteredProductsEvent>(_onFilteredProductsEvent);
  }

  /// Handles fetching initial categories and products
  Future<void> _onFetchProductDataEvent(
      FetchProductDataEvent event, Emitter<ProductState> emit) async {
    emit(ProductsLoading());
    emit(ProductCategoriesLoading());
    try {
      // Fetch categories
      final categories = await productRepo.getProductCategories();
      if (categories.isEmpty) {
        emit(ProductsError(message: "No categories available"));
        return;
      }
      categories.insert(0, ProductCategoryModel(name: "All", url: baseUrl));
      emit(ProductCategoriesLoaded(categories: categories));

      // Fetch products
      final products = await productRepo.getProducts(page);
      if (products.isEmpty) {
        emit(ProductsError(message: "No products available"));
        return;
      }
      _products = products;
      emit(ProductsLoaded(products: products));
      page++;
    } catch (error) {
      emit(ProductsError(message: "Failed to load data: $error"));
    }
  }

  Future<void> _onFetchProductsByCategory(
      FetchProductsByCategory event, Emitter<ProductState> emit) async {
    // Reset page and fetch products for the selected category
    page = 1;
    try {
      // Fetch products by categories
      final products = await productRepo.getProductsByCategory(event.url);
      if (products.isEmpty) {
        emit(ProductsError(message: "No products available"));
        return;
      }
      _products = products;
      emit(ProductsLoaded(products: products));
    } catch (error) {
      emit(ProductsError(message: "Failed to load data: $error"));
    }
  }

  /// Handles fetching more products (pagination)
  Future<void> _onFetchMoreProductsEvent(
      FetchMorePorductsEvent event, Emitter<ProductState> emit) async {
    if (isFetchingMore) return; // Prevent multiple triggers
    isFetchingMore = true;
    try {
      final products = await productRepo.getProducts(page);
      if (products.isEmpty) {
        emit(ProductsError(message: "No more products available"));
        isFetchingMore = false;
        return;
      }

      // Append new products to the current state
      if (state is ProductsLoaded) {
        final currentProducts = (state as ProductsLoaded).products;
        _products =  [...currentProducts, ...products];
        emit(ProductsLoaded(products: [...currentProducts, ...products]));
      } else {
        _products = products;
        emit(ProductsLoaded(products: products));
      }
      page++;
    } catch (error) {
      emit(ProductsError(message: "Failed to load more products: $error"));
    } finally {
      isFetchingMore = false;
    }
  }

  FutureOr<void> _onSearchProductEvent(
      SearchProductEvent event, Emitter<ProductState> emit) {
    if (event.list.isNotEmpty) {
      emit(ProductsLoaded(products: event.list));
    }
  }

  void _onFilteredProductsEvent(
    FilteredProductsEvent event, Emitter<ProductState> emit
  ) {
    final filtered = _products.where((product) {
      final name = (product.title != null) ? product.title!.toLowerCase() : "";
      final brand = (product.brand != null) ? product.brand!.toLowerCase() : "";
      final searchQuery = event.query.toLowerCase();

      return name.contains(searchQuery) || brand.contains(searchQuery);
    }).toList();
    emit(FilteredLoaded(products: filtered));
  }
}
