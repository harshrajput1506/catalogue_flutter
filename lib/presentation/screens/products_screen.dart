import 'package:catalogue_project/core/constants.dart';
import 'package:catalogue_project/domain/models/product_category_model.dart';
import 'package:catalogue_project/domain/models/product_model.dart';
import 'package:catalogue_project/presentation/blocs/cart/cart_bloc.dart';
import 'package:catalogue_project/presentation/blocs/cart/cart_event.dart';
import 'package:catalogue_project/presentation/blocs/cart/cart_state.dart';
import 'package:catalogue_project/presentation/blocs/product/product_bloc.dart';
import 'package:catalogue_project/presentation/blocs/product/product_event.dart';
import 'package:catalogue_project/presentation/blocs/product/product_state.dart';
import 'package:catalogue_project/presentation/screens/cart_screen.dart';
import 'package:catalogue_project/presentation/widgets/category_widget.dart';
import 'package:catalogue_project/presentation/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController _scrollController = ScrollController();
  int _selectedCategoryIndex = 0;
  List<ProductCategoryModel> _categories = [];
  bool isLoadMore = true;

  @override
  void initState() {
    super.initState();
    // Fetch initial categories and products
    BlocProvider.of<ProductBloc>(context).add(FetchProductDataEvent());

    // Add scroll listener for pagination
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      if (isLoadMore)
        BlocProvider.of<ProductBloc>(context).add(FetchMorePorductsEvent());
    }
  }

  void _addToCart(ProductModel product) {
    BlocProvider.of<CartBloc>(context).add(AddProductEvent(product: product));
  }

  void _goToCartScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CartScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // App Bar
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Catalogue",
                    style: GoogleFonts.nunito(
                      fontSize: 42.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // The Cart Icon
                      IconButton(
                        onPressed: () {
                          // Navigate to cart screen
                          _goToCartScreen();
                        },
                        icon: const Icon(Icons.shopping_cart),
                        iconSize: 28.0,
                        color: Colors.black87,
                      ),

                      // The Red Dot with Cart Items Count
                      Positioned(
                        right: 5,
                        top:
                            -1, // Adjust the position to place it above the icon
                        child: BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            if (state is UpdatedCart && state.cart.isNotEmpty) {
                              final totalItems = state.cart.fold<int>(
                                0,
                                (sum, cartModel) => sum + cartModel.quantity,
                              );

                              return Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '$totalItems',
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                            return const SizedBox
                                .shrink(); // Show nothing if cart is empty
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // Category List
            BlocListener<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductCategoriesLoaded) {
                  setState(() {
                    _categories = state.categories;
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: SizedBox(
                  height: 50.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return CategoryWidget(
                        text: _categories[index].name,
                        isSelected: (index == _selectedCategoryIndex),
                        index: index,
                        onSelected: (selectedIndex) {
                          setState(
                              () => _selectedCategoryIndex = selectedIndex);
                          isLoadMore = selectedIndex == 0;
                          if (selectedIndex == 0) {
                            BlocProvider.of<ProductBloc>(context).add(
                              FetchProductDataEvent(),
                            );
                          } else {
                            BlocProvider.of<ProductBloc>(context).add(
                              FetchProductsByCategory(
                                  url: _categories[selectedIndex].url ??
                                      baseUrl),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ),

            // Product Grid
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductsLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GridView.builder(
                        controller: _scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          childAspectRatio: 0.55,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return ProductWidget(
                            product: state.products[index],
                            addToCart: () => _addToCart(state.products[index]),
                          );
                        },
                      ),
                    );
                  } else if (state is ProductsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProductsError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("No products available"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
