import 'package:catalogue_project/domain/models/cart_model.dart';
import 'package:catalogue_project/presentation/blocs/cart/cart_event.dart';
import 'package:catalogue_project/presentation/blocs/cart/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  List<CartModel> cart = [];

  CartBloc() : super(InitialCart(cart: [])) {
    on<AddProductEvent>(_onAddProductEvent);
    on<RemoveProductEvent>(_onRemoveProductEvent);
    on<InitiateCartEvent>(_initiateCartEvent);
  }

  void  _initiateCartEvent(InitiateCartEvent event, Emitter<CartState> emit) {
    emit(UpdatedCart(cart: cart));
  }
   void _onAddProductEvent(AddProductEvent event, Emitter<CartState> emit){
    int index = cart.indexWhere((cartModel) => cartModel.product.id == event.product.id);

    if(index == -1){
      cart.add(CartModel(product: event.product, quantity: 1));
      emit(UpdatedCart(cart: cart));
      return;
    }else {
      int quantity = cart[index].quantity + 1;
      cart[index] = cart[index].copyWith(quantity: quantity);
      emit(UpdatedCart(cart: cart));
    }
   }

   void _onRemoveProductEvent(RemoveProductEvent event, Emitter<CartState> emit){
    int index = cart.indexWhere((cartModel) => cartModel.product.id == event.product.id);
    if(index == -1) return;
    if(cart[index].quantity>1){
      int quantity = cart[index].quantity - 1;
      cart[index] = cart[index].copyWith(quantity: quantity);
      emit(UpdatedCart(cart: cart));
    } else {
      cart.removeAt(index);
      emit(UpdatedCart(cart: cart));
    }
   }

  
}