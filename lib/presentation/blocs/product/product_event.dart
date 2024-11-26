abstract class ProductEvent {}

class FetchProductEvent extends ProductEvent  {
  final int page;

  FetchProductEvent({required this.page});
  
}