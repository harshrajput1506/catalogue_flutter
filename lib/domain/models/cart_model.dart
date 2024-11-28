import 'package:catalogue_project/domain/models/product_model.dart';

class CartModel {
  final ProductModel product;
  int quantity;

  CartModel({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => (product.price ?? 0) * quantity;
  double get totalDiscountedPrice => product.discountedPrice * quantity;

  CartModel copyWith({int? quantity}) {
    return CartModel(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }
}