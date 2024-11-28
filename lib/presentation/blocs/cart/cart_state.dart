import 'package:catalogue_project/domain/models/cart_model.dart';

abstract class CartState {}

class UpdatedCart extends CartState {
  final List<CartModel> cart;

  UpdatedCart({required this.cart});
}
class InitialCart extends CartState{
  final List<CartModel> cart;
  InitialCart({required this.cart});
}

class CheckOut extends CartState {}