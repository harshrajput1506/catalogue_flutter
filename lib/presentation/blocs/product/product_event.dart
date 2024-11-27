abstract class ProductEvent {}

class FetchProductEvent extends ProductEvent  {
  final int page;

  FetchProductEvent({required this.page});
  
}

class FetchProductCategoryEvent extends ProductEvent {
}

class SelectProductCategoryEvent extends ProductEvent {
  final int index;
  SelectProductCategoryEvent({required this.index});
}