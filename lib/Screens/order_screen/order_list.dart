// lib/screens/orders_list.dart

import 'package:flutter/material.dart';
import 'package:my_urban_care/Screens/order_screen/order_card.dart';
import 'package:my_urban_care/model/order.dart';
import 'package:my_urban_care/model/order_info.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  // Using the sample order data from sample_data.dart
  final List<Order> ordersList = orders;

  @override
  Widget build(BuildContext context) {
    if (ordersList.isEmpty) {
      return const Center(
        child: Text(
          'No active orders.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: ordersList.length,
      itemBuilder: (context, index) {
        final Order order = ordersList[index];
        return OrderCard(order: order);
      },
    );
  }
}
