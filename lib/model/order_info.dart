// lib/model/order_info.dart

import 'package:my_urban_care/model/order.dart';

List<Order> orders = [
  Order(
    orderNumber: '12345',
    dateOfPickup: '12/09/2024',
    status: 'Confirmed',
    quantity: 8,
    price: 75.00,
    details: 'Laundry service for 5 shirts, 2 pants, and 1 bedsheet',
    statusTimeline: {
      'Order Placed': '12:00 PM, 10/09/2024',
      'Packed': '10:00 AM, 11/09/2024',
      'Picked': '2:00 PM, 11/09/2024',
      'Delivered': 'N/A',
    },
  ),
  Order(
    orderNumber: '12346',
    dateOfPickup: '13/09/2024',
    status: 'Picked',
    quantity: 5,
    price: 45.00,
    details: 'Laundry service for 3 dresses and 2 towels',
    statusTimeline: {
      'Order Placed': '1:00 PM, 12/09/2024',
      'Packed': '3:00 PM, 12/09/2024',
      'Picked': '5:00 PM, 12/09/2024',
      'Delivered': 'N/A',
    },
  ),
  Order(
    orderNumber: '12347',
    dateOfPickup: '14/09/2024',
    status: 'Delivered',
    quantity: 6,
    price: 60.00,
    details: 'Laundry service for 2 suits and 4 shirts',
    statusTimeline: {
      'Order Placed': '9:00 AM, 13/09/2024',
      'Packed': '11:00 AM, 13/09/2024',
      'Picked': '1:00 PM, 13/09/2024',
      'Delivered': '4:00 PM, 14/09/2024',
    },
  ),
];
