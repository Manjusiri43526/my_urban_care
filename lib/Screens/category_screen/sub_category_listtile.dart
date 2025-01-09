// lib/widgets/product_tile.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_urban_care/model/product_model.dart';
import 'package:provider/provider.dart';
import '../../provider/bucket_provider.dart';
import '../common/colors.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using Consumer to listen to changes in BucketProvider
    return Consumer<BucketProvider>(
      builder: (context, bucketProvider, child) {
        int quantity = bucketProvider.getQuantity(product.id);

        return Card(
          elevation: 4, // Adds shadow for depth
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adds space around the card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0), // Inner padding within the card
            child: Row(
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SvgPicture.asset(
                    product.image,
                    width: 80, // Increased width for longer item
                    height: 80,
                    fit: BoxFit.cover,
                    placeholderBuilder: (BuildContext context) => Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 16), // Space between image and details

                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Title
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 18, // Increased font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Quantity Controls
                      Row(
                        children: [
                          // Decrement Button
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              bucketProvider.decrementQuantity(product.id);
                            },
                          ),

                          // Quantity Display
                          Text(
                            '$quantity',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // Increment Button
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              if (quantity == 0) {
                                // Add product to bucket with quantity = 1
                                bucketProvider.addProduct(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          '${product.title} added to bucket')),
                                );
                              } else {
                                // Increment existing quantity
                                bucketProvider.incrementQuantity(product.id);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Product Price
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.production_quantity_limits,
                            size: 16, color: Colors.grey[600]),
                        Text(
                          ' x ${quantity}',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          ' =${(product.price * quantity).toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),

                    Text(
                      '₹${(product.price * quantity).toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 18, // Increased font size
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
