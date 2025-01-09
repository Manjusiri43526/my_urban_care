import 'package:flutter/material.dart';
import 'package:my_urban_care/Screens/order_screen/order_details_page.dart';
import 'package:my_urban_care/model/order.dart';
import '../common/colors.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Order Details Page when the entire card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsPage(order: order),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
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
                      Icons.currency_rupee,
                      color: primary,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${order.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Delivery Time and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery Time: ${order.statusTimeline['deliveryTime'] ?? 'N/A'}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7D848D),
                  ),
                ),
                Text(
                  'Status: ${order.status}',
                  style: TextStyle(
                    fontSize: 14,
                    color: order.status == 'Delivered' ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // View Details Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Navigate to Order Details Page when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailsPage(order: order),
                    ),
                  );
                },
                child: const Text(
                  'View Details',
                  style: TextStyle(fontSize: 16, color: primary,
                  decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
