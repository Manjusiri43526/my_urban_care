// lib/pages/SubscriptionPage.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../provider/subscription_provider.dart';
import '../../provider/wallet_provider.dart';
import '../model/subscription_plan_model.dart';
import '../model/user_subscription_model.dart';
import 'Thank_you_page.dart';
import 'common/colors.dart';
import 'wallet_screen.dart'; // Ensure the correct path

/// Enum for Payment Methods
enum PaymentMethod { Wallet, Other }

class SubscriptionPage extends StatelessWidget {
  static const routeName = '/subscription';

  @override
  Widget build(BuildContext context) {
    final subscriptionProvider = Provider.of<SubscriptionProvider>(context);
    final plans = subscriptionProvider.plans;
    final currentSubscription = subscriptionProvider.currentSubscription;
    final subscriptionHistory = subscriptionProvider.subscriptionHistory;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subscription Plans',
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: white),
        centerTitle: true,
        backgroundColor: primary,
        actions: [
          IconButton(
            icon: Icon(Icons.account_balance_wallet, color: white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WalletPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Current Subscription Section
            if (currentSubscription != null)
              _buildCurrentSubscription(currentSubscription),
            if (currentSubscription != null) Divider(),
            // Available Plans Section
            _buildAvailablePlans(plans, context, subscriptionProvider),
            Divider(),
            // Subscription History Section
            _buildSubscriptionHistory(subscriptionHistory),
          ],
        ),
      ),
    );
  }

  /// Builds the current subscription section
  Widget _buildCurrentSubscription(UserSubscription subscription) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm a');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Subscription',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.subscriptions, color: primary, size: 30),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subscription.planName,
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Valid from ${formatter.format(subscription.startDate)}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    Text(
                      'Valid until ${formatter.format(subscription.endDate)}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.cancel, color: Colors.red),
                onPressed: () {
                  _confirmCancellation;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the available subscription plans section
  Widget _buildAvailablePlans(List<SubscriptionPlan> plans, BuildContext context,
      SubscriptionProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Choose a Plan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: plans.length,
            itemBuilder: (context, index) {
              final plan = plans[index];
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading:
                  Icon(Icons.local_offer, color: primary, size: 40),
                  title: Text(
                    plan.name,
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(plan.description),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '\₹ ${plan.price.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primary),
                      ),
                      Text(
                        'for ${_formatDuration(plan.duration)}',
                        style:
                        TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  onTap: () {
                    _confirmSubscription(context, plan, provider);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Builds the subscription history section
  Widget _buildSubscriptionHistory(List<UserSubscription> history) {
    if (history.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'No subscription history available.',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Subscription History',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: history.length,
            itemBuilder: (context, index) {
              final subscription = history[index];
              final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm a');
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  leading: Icon(Icons.history, color: primary),
                  title: Text(subscription.planName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Paid: \₹${subscription.amountPaid.toStringAsFixed(2)}',
                        style:
                        TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      Text(
                        'Valid from ${formatter.format(subscription.startDate)}',
                        style:
                        TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      Text(
                        'Valid until ${formatter.format(subscription.endDate)}',
                        style:
                        TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Formats Duration to a readable string
  String _formatDuration(Duration duration) {
    if (duration.inDays >= 365) {
      int years = duration.inDays ~/ 365;
      return '$years year${years > 1 ? 's' : ''}';
    } else if (duration.inDays >= 30) {
      int months = duration.inDays ~/ 30;
      return '$months month${months > 1 ? 's' : ''}';
    } else {
      return '${duration.inDays} day${duration.inDays > 1 ? 's' : ''}';
    }
  }

  /// Confirms subscription before proceeding
  void _confirmSubscription(BuildContext context, SubscriptionPlan plan,
      SubscriptionProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Subscription'),
        content: Text(
            'Do you want to subscribe to the ${plan.name} plan for \₹${plan.price.toStringAsFixed(2)}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _processSubscription(context, plan, provider);
            },
            child: Text('Confirm',style: TextStyle(color: white),),
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
            ),
          ),
        ],
      ),
    );
  }

  /// Processes the subscription payment and updates the state
  void _processSubscription(BuildContext context, SubscriptionPlan plan,
      SubscriptionProvider provider) {
    // Show payment method selection
    showDialog(
      context: context,
      builder: (context) => PaymentMethodDialog(
        totalPrice: plan.price,
        onPaymentSelected: (PaymentMethod method) {
          Navigator.pop(context);
          if (method == PaymentMethod.Wallet) {
            _payWithWallet(context, plan, provider);
          } else {
            _payWithOtherMethods(context, plan, provider);
          }
        },
      ),
    );
  }

  /// Handles payment using the wallet
  void _payWithWallet(BuildContext context, SubscriptionPlan plan,
      SubscriptionProvider provider) {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    if (walletProvider.wallet.balance >= plan.price) {
      walletProvider.deductFunds(plan.price);
      provider.subscribe(plan);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Subscribed to ${plan.name} plan using Wallet!')),
      );

      // Navigate to Thank You Page
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ThankYouPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Insufficient wallet balance! Please add funds.')),
      );
    }
  }

  /// Handles payment using other methods (e.g., Credit/Debit Card)
  void _payWithOtherMethods(BuildContext context, SubscriptionPlan plan,
      SubscriptionProvider provider) {
    // Implement actual payment gateway integration here
    // For demonstration, we'll assume payment is successful

    provider.subscribe(plan);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Subscribed to ${plan.name} plan successfully!')),
    );

    // Navigate to Thank You Page
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ThankYouPage()),
    );
  }

  /// Confirms cancellation of current subscription
  void _confirmCancellation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancel Subscription'),
        content:
        Text('Are you sure you want to cancel your current subscription?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<SubscriptionProvider>(context, listen: false)
                  .cancelSubscription();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Subscription cancelled successfully!')),
              );
              Navigator.pop(context);
            },
            child: Text('Yes'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

/// Payment Method Selection Dialog
class PaymentMethodDialog extends StatelessWidget {
  final double totalPrice;
  final Function(PaymentMethod) onPaymentSelected;

  const PaymentMethodDialog({
    Key? key,
    required this.totalPrice,
    required this.onPaymentSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Choose Payment Method'),
      content:
      Text('How would you like to pay \₹${totalPrice.toStringAsFixed(2)}?'),
      actions: [
        TextButton(
          onPressed: () => onPaymentSelected(PaymentMethod.Wallet),
          child: Text('Wallet'),
        ),
        TextButton(
          onPressed: () => onPaymentSelected(PaymentMethod.Other),
          child: Text('Credit/Debit Card'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
