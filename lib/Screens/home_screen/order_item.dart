

import 'package:flutter/material.dart';
import 'package:my_urban_care/model/order.dart';
import 'package:my_urban_care/screens/order_screen/order_details_page.dart';
import 'package:my_urban_care/screens/common/colors.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to OrderDetailsPage with the selected order
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsPage(order: order),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8, left: 16,right: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID and Date of Pickup
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: #${order.orderNumber}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  order.dateOfPickup,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7D848D),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Quantity and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Quantity
                Row(
                  children: [
                    const Icon(
                      Icons.local_laundry_service,
                      color: primary,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${order.quantity} Items',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF7D848D),
                      ),
                    ),
                  ],
                ),
                // Price
                Row(
                  children: [
                    const Icon(
                      Icons.attach_money,
                      color: primary,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '\$${order.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF7D848D),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
