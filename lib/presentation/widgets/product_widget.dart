
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  final String url =
      "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png"; // Placeholder image for products

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            url,
            height: 150.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
            "Product Name",
            style: GoogleFonts.nunito(fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
            "Brand Name",
            style: GoogleFonts.nunito(fontSize: 10.0, fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "49.9",
                            style: GoogleFonts.nunito(
                              fontSize: 10.0, color: Colors.grey, decoration: TextDecoration.lineThrough
                            ),
                          ),
                          SizedBox(width: 4.0,),
                          Text(
                            "40.99",
                            style: GoogleFonts.nunito(
                              fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                  
                      Text(
                            "12.9% OFF",
                            style: GoogleFonts.nunito(
                              fontSize: 10.0, color: Colors.red.shade400, fontWeight: FontWeight.bold
                            ),
                          )
                      
                    ],
                  ),
                ),
                Card.filled(
                  shape: const CircleBorder(),
                  color: Colors.blueGrey,
                  child: IconButton(
                    onPressed: (){}, 
                    icon: const Icon(Icons.add),
                    color: Colors.white,
                    iconSize: 24.0,
                  ),
                ),
              
              ],
            ),
          )
          
        ],
      ),
    );
  }
}
