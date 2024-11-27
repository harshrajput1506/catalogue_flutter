import 'package:catalogue_project/domain/models/product_category_model.dart';
import 'package:catalogue_project/presentation/blocs/product/product_bloc.dart';
import 'package:catalogue_project/presentation/blocs/product/product_event.dart';
import 'package:catalogue_project/presentation/blocs/product/product_state.dart';
import 'package:catalogue_project/presentation/widgets/category_widget.dart';
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
  bool _isLoading = false;

  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(FetchProductCategoryEvent());
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent &&
      !_isLoading) {
    setState(() => _isLoading = true);

    // Simulate fetching more data
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        // Append more items to your product list
      });
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
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
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.shopping_cart),
                        color: Colors.black87,
                        tooltip: '0',
                        iconSize: 28.0,
                      )
                    ],
                  ),
                ),
            
                // BlocConsumer for dynamic categories
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductCategoriesLoaded) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: SizedBox(
                          height: 50.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              return CategoryWidget(
                                text: state.categories[index].name, 
                                isSelected: (index == _selectedCategoryIndex),
                                index: index,
                                onSelected: (selectedIndex) {
                                  setState(() => _selectedCategoryIndex = selectedIndex);
                                  // Fetch Products By Category
                                },
                                 );
                            },
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox(height: 50.0,);
                    }
                  },
                ),
            
            
                // GridView for products
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      controller: _scrollController,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.0,
                        crossAxisSpacing: 12.0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: 10, // Replace with the product list length
                      itemBuilder: (context, index) {
                        return const ProductWidget();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  final String url =
      "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png"; // Placeholder image for products

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Image.network(
            url,
            height: 160.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8.0),
          Text(
            "Product Name",
            style: GoogleFonts.nunito(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
