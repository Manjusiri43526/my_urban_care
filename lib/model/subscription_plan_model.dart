// lib/model/subscription_plan.dart

class SubscriptionPlan {
  final String id;
  final String name;
  final String description;
  final double price;
  final Duration duration; // e.g., Duration(days: 30) for monthly

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
  });
}
