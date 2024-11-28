import 'package:catalogue_project/core/theme/colors.dart';
import 'package:catalogue_project/domain/models/product_model.dart';
import 'package:catalogue_project/presentation/blocs/cart/cart_bloc.dart';
import 'package:catalogue_project/presentation/blocs/cart/cart_event.dart';
import 'package:catalogue_project/presentation/blocs/cart/cart_state.dart';
import 'package:catalogue_project/presentation/widgets/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    BlocProvider.of<CartBloc>(context).add(InitiateCartEvent());
    super.initState();
  }

  void _backToProductScreen() {
    Navigator.pop(context);
  }

  void _incrementProduct(ProductModel product) {
    BlocProvider.of<CartBloc>(context).add(AddProductEvent(product: product));
  }

  void _decrementProduct(ProductModel product) {
    BlocProvider.of<CartBloc>(context)
        .add(RemoveProductEvent(product: product));
  }

  void _onCheckOut(){
    BlocProvider.of<CartBloc>(context)
        .add(CheckOutCartEvent());
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ghostWhite,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar Section
            Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, right: 18, left: 18.0, bottom: 4.0),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  IconButton(
                    onPressed: () {
                      _backToProductScreen();
                    },
                    icon: const Icon(Icons.keyboard_arrow_left_rounded),
                    iconSize: 36.0,
                  ),
                  Center(
                    child: Text(
                      "Cart",
                      style: GoogleFonts.nunito(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product List Section
            Expanded(
              child: BlocConsumer<CartBloc, CartState>(
                listener: (context, state) {
                  if(state is CheckOut){
                    _showSnackBar(context, "Checkout Complete!");
                  }
                },
                builder: (context, state) {
                if (state is UpdatedCart && state.cart.isNotEmpty) {
                  final totalItems = state.cart
                      .fold<int>(0, (sum, cartModel) => sum + cartModel.quantity);
                  final totalAmount = state.cart.fold<double>(0.0,
                      (sum, cartModel) => sum + cartModel.totalDiscountedPrice);
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(12.0),
                          itemCount: state.cart.length, // Example with 5 items
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: CarProducttWidget(
                                cartProduct: state.cart[index],
                                decrementQuantity: () {
                                  _decrementProduct(state.cart[index].product);
                                },
                                incrementQuantity: () {
                                  _incrementProduct(state.cart[index].product);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total',
                                  style: GoogleFonts.nunito(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  '\$${totalAmount.toStringAsFixed(2)}',
                                  style: GoogleFonts.nunito(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _onCheckOut();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade400,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Checkout',
                                    style: GoogleFonts.nunito(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        totalItems.toString(),
                                        style: GoogleFonts.nunito(
                                            fontSize: 12.0,
                                            color: Colors.red.shade400,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'Empty Cart',
                        style: GoogleFonts.nunito(fontSize: 18.0),
                      ),
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
