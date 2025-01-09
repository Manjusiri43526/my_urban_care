import 'package:flutter/material.dart';
import '../model/subscription_plan_model.dart';
import 'dart:math';

import '../model/user_subscription_model.dart';

class SubscriptionProvider with ChangeNotifier {
  // List of available subscription plans
  List<SubscriptionPlan> _plans = [
    SubscriptionPlan(
      id: 'basic',
      name: 'Basic',
      description: 'Access to standard features',
      price: 299.00,
      duration: Duration(days: 30),
    ),
    SubscriptionPlan(
      id: 'premium',
      name: 'Premium',
      description: 'Access to premium features',
      price: 599.00,
      duration: Duration(days: 30),
    ),
    SubscriptionPlan(
      id: 'annual',
      name: 'Annual',
      description: 'Access to all features for a year',
      price: 5999.00,
      duration: Duration(days: 365),
    ),
  ];

  // User's current subscription
  UserSubscription? _currentSubscription;

  // List of user's past subscriptions
  List<UserSubscription> _subscriptionHistory = [];

  List<SubscriptionPlan> get plans => _plans;
  UserSubscription? get currentSubscription => _currentSubscription;
  List<UserSubscription> get subscriptionHistory => _subscriptionHistory;

  /// Subscribe to a plan
  void subscribe(SubscriptionPlan plan) {
    final now = DateTime.now();
    final endDate = now.add(plan.duration);

    _currentSubscription = UserSubscription(
      planId: plan.id,
      planName: plan.name,
      amountPaid: plan.price,
      startDate: now,
      endDate: endDate,
    );

    _subscriptionHistory.add(_currentSubscription!);
    notifyListeners();
  }

  /// Renew the current subscription
  void renewSubscription(SubscriptionPlan plan) {
    if (_currentSubscription != null) {
      final newEndDate = _currentSubscription!.endDate.add(plan.duration);
      _currentSubscription = UserSubscription(
        planId: plan.id,
        planName: plan.name,
        amountPaid: plan.price,
        startDate: _currentSubscription!.endDate,
        endDate: newEndDate,
      );
      _subscriptionHistory.add(_currentSubscription!);
      notifyListeners();
    }
  }

  /// Cancel the current subscription
  void cancelSubscription() {
    _currentSubscription = null;
    notifyListeners();
  }

  /// Generate a unique transaction ID
  String _generateTransactionId() {
    return DateTime.now().millisecondsSinceEpoch.toString() +
        Random().nextInt(1000).toString();
  }
}
