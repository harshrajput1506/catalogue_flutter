import 'package:catalogue_project/domain/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarProducttWidget extends StatelessWidget {
  final CartModel cartProduct;
  final Function() incrementQuantity;
  final Function() decrementQuantity;

  const CarProducttWidget(
      {super.key,
      required this.cartProduct,
      required this.incrementQuantity,
      required this.decrementQuantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                cartProduct.product.thumbnail ?? '',
                height: 100.0,
                width: 100.0,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.grey.shade300,
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: 50.0,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 4.0),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    cartProduct.product.title ?? 'Unknown Product',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunito(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  // Brand Name
                  Text(
                    cartProduct.product.brand ?? 'Unknown Brand',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunito(
                      fontSize: 12.0,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 8.0),

                  // Price and Discount Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Price Details
                          Row(
                            children: [
                              Text(
                                '\$${cartProduct.totalPrice.toStringAsFixed(2)}',
                                style: GoogleFonts.nunito(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                '\$${cartProduct.totalDiscountedPrice.toStringAsFixed(2)}',
                                style: GoogleFonts.nunito(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          // Discount
                          if (cartProduct.product.discountPercentage != null &&
                              cartProduct.product.discountPercentage! > 0)
                            Text(
                              '${cartProduct.product.discountPercentage!.toStringAsFixed(1)}% OFF',
                              style: GoogleFonts.nunito(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade400,
                              ),
                            ),
                        ],
                      ),
                      if(cartProduct.totalDiscountedPrice.toStringAsFixed(2).length<=5)
                        QuantitySelector(quantity: cartProduct.quantity, decrementQuantity: decrementQuantity, incrementQuantity: incrementQuantity)
                    ],
                  ),
                  const SizedBox(height: 4.0,),
                  if(cartProduct.totalDiscountedPrice.toStringAsFixed(2).length>5)
                      QuantitySelector(quantity: cartProduct.quantity, decrementQuantity: decrementQuantity, incrementQuantity: incrementQuantity)
                    
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final Function() incrementQuantity;
  final Function() decrementQuantity;

  const QuantitySelector(
      {super.key,
      required this.quantity,
      required this.decrementQuantity,
      required this.incrementQuantity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Decrement Button
          GestureDetector(
            onTap: decrementQuantity,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueGrey, // Background color
              ),
              padding: const EdgeInsets.all(4.0),
              child: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 18.0,
              ),
            ),
          ),

          // Quantity Display
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              quantity.toString(),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Increment Button
          GestureDetector(
            onTap: incrementQuantity,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueGrey, // Background color
              ),
              padding: const EdgeInsets.all(4.0),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
