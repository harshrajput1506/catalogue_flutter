import 'package:catalogue_project/domain/models/product_model.dart';
import 'package:flutter/material.dart';

abstract class ProductEvent {}

class FetchProductDataEvent extends ProductEvent  {}

class FetchMorePorductsEvent extends ProductEvent {}

class FetchProductsByCategory extends ProductEvent {
  final String url;
  FetchProductsByCategory({ required this.url});
}

class SearchProductEvent extends ProductEvent {
  final List<ProductModel> list;
  SearchProductEvent({ 
    required this.list
  });
}

class FilteredProductsEvent extends ProductEvent {
  final String query;
  FilteredProductsEvent({ 
    required this.query
  });
}