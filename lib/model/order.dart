

// lib/model/order.dart

class Order {
  final String orderNumber;
  final String dateOfPickup;
  final String status;
  final int quantity;
  final double price;
  final String details;
  final Map<String, String> statusTimeline;

  Order({
    required this.orderNumber,
    required this.dateOfPickup,
    required this.status,
    required this.quantity,
    required this.price,
    required this.details,
    required this.statusTimeline,
  });
}
