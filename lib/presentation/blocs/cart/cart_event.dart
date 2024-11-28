import 'package:catalogue_project/domain/models/product_model.dart';

abstract class CartEvent {}

class AddProductEvent extends CartEvent {
  bool isFirst;
  final ProductModel product;
 

  AddProductEvent({required this.product, this.isFirst = false});

}

class RemoveProductEvent extends CartEvent {
  final ProductModel product;

  RemoveProductEvent({required this.product});
}

class InitiateCartEvent extends CartEvent {}

class CheckOutCartEvent extends CartEvent{}