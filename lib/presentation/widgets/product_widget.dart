import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catalogue_project/domain/models/product_model.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;
  final Function() addToCart;

  const ProductWidget({super.key, required this.product, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stack to layer the product image and add to cart button
          Stack(
            clipBehavior: Clip.none, // Allows the button to be outside the image bounds
            children: [
              // Product Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                child: Image.network(
                  product.thumbnail ?? '', // Fallback in case of null
                  height: 150.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 150.0,
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 50.0,
                    ),
                  ),
                ),
              ),
              // Add to Cart Button
              Positioned(
                bottom: 8.0, // Position the button at the bottom
                right: 8.0, // Align it to the right of the image
                child: Card(
                  shape: const CircleBorder(),
                  color: Colors.blueGrey,
                  child: IconButton(
                    onPressed: () {
                      // Handle "Add to Cart" action
                      addToCart();
                    },
                    icon: const Icon(Icons.add),
                    color: Colors.white,
                    iconSize: 18.0, // Smaller icon size
                    constraints: const BoxConstraints(
                      minWidth: 32.0, // Smaller width
                      minHeight: 32.0, // Smaller height
                    ),
                    padding: const EdgeInsets.all(4.0), // Less padding for a compact look
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8.0),

          // Product Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              product.title ?? 'Unknown Product',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Brand Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              product.brand ?? 'Unknown Brand',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                color: Colors.grey.shade600,
              ),
            ),
          ),

          // Price and Discount
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Pricing Details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Original Price
                        if (product.discountPercentage != null)
                          Text(
                            '\$${(product.price ?? 0).toStringAsFixed(2)}',
                            style: GoogleFonts.nunito(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const SizedBox(width: 4.0),
                        // Discounted Price
                        Text(
                          '\$${product.discountedPrice.toStringAsFixed(2)}',
                          style: GoogleFonts.nunito(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // Discount Percentage
                    if (product.discountPercentage != null && product.discountPercentage! > 0)
                      Text(
                        '${product.discountPercentage!.toStringAsFixed(1)}% OFF',
                        style: GoogleFonts.nunito(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade400,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
