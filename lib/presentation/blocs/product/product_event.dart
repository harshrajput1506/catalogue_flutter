abstract class ProductEvent {}

class FetchProductDataEvent extends ProductEvent  {}

class FetchMorePorductsEvent extends ProductEvent {}

class FetchProductsByCategory extends ProductEvent {
  final String url;
  FetchProductsByCategory({ required this.url});
}