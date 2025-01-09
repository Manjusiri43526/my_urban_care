import 'package:flutter/material.dart';
import 'package:my_urban_care/Screens/order_screen/order_list.dart';

import '../common/colors.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: white,
        ),
        title: const Text('My Orders',style: TextStyle(color: white),),
        centerTitle: true,
        backgroundColor: primary,
      ),
      body: const OrdersList(),
    );
  }
}
