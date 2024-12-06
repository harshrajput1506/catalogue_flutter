import 'package:catalogue_project/core/theme/colors.dart';
import 'package:catalogue_project/domain/models/product_model.dart';
import 'package:catalogue_project/presentation/blocs/cart/cart_bloc.dart';
import 'package:catalogue_project/presentation/blocs/cart/cart_event.dart';
import 'package:catalogue_project/presentation/blocs/product/product_bloc.dart';
import 'package:catalogue_project/presentation/blocs/product/product_event.dart';
import 'package:catalogue_project/presentation/blocs/product/product_state.dart';
import 'package:catalogue_project/presentation/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  List<ProductModel> _filteredProducts = [];
  List<ProductModel> _list = [];
  

   @override
  void initState() {
    super.initState();
    
  
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });

     _searchController.addListener(() {
      BlocProvider.of<ProductBloc>(context).add(FilteredProductsEvent(query: _searchController.text));
      
    });
    
  }

  void _addToCart(ProductModel product) {
    BlocProvider.of<CartBloc>(context).add(AddProductEvent(product: product));
  }

   @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  
  
  // void _filterProducts(String query) {
  //   final filtered = _list.where((product) {
  //     final name = (product.title != null) ? product.title!.toLowerCase() : "";
  //     final brand = (product.brand != null) ? product.brand!.toLowerCase() : "";
  //     final searchQuery = query.toLowerCase();

  //     return name.contains(searchQuery) || brand.contains(searchQuery);
  //   }).toList();
  //   print("filter list $filtered");


  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ghostWhite,
      body: Column(
        children: [
          Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          decoration: const InputDecoration(
            labelText: "Search",
            hintText: "Enter search text",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),

      // Product Grid
            Expanded(
              child: BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                  if(state is ProductsLoaded){
                    _filteredProducts = state.products;
                    _list = state.products;
                  }
                },
                builder: (context, state) {
                  if (state is FilteredLoaded) {
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
    );
  }
}