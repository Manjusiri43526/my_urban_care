import 'package:flutter/material.dart';
import 'package:my_urban_care/Screens/transection_history_page.dart';
import 'package:provider/provider.dart';
import '../../provider/wallet_provider.dart';
import '../../provider/subscription_provider.dart'; // Import the SubscriptionProvider
import 'package:intl/intl.dart';

import '../model/user_subscription_model.dart';
import '../model/wallet_model.dart';
import 'common/colors.dart';

class WalletPage extends StatelessWidget {
  static const routeName = '/wallet';

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    final wallet = walletProvider.wallet;
    final subscriptionProvider = Provider.of<SubscriptionProvider>(context);
    final currentSubscription = subscriptionProvider.currentSubscription;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Wallet',
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: white),
        centerTitle: true,
        backgroundColor: primary,
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: white),
            tooltip: 'Transaction History',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TransactionHistoryPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildBalanceSection(wallet.balance),
          Divider(),
          _buildAddFundsSection(context, walletProvider),
          Divider(),
          _buildCurrentSubscriptionSection(currentSubscription),
          // Removed Transaction History Section
        ],
      ),
    );
  }

  /// Builds the wallet balance section
  Widget _buildBalanceSection(double balance) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      color: Colors.grey[100],
      child: Column(
        children: [
          Icon(
            Icons.account_balance_wallet,
            size: 50,
            color: primary,
          ),
          SizedBox(height: 16),
          Text(
            'Wallet Balance',
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
          SizedBox(height: 8),
          Text(
            '\₹ ${balance.toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: primary),
          ),
        ],
      ),
    );
  }

  /// Builds the add funds section
  Widget _buildAddFundsSection(BuildContext context, WalletProvider walletProvider) {
    final TextEditingController _amountController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Add Funds',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.currency_rupee),
            ),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              final String input = _amountController.text;
              final double? amount = double.tryParse(input);
              if (amount != null && amount > 0) {
                walletProvider.addFunds(amount);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added ₹$amount to wallet')),
                );
                _amountController.clear();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter a valid amount')),
                );
              }
            },
            child: Text('Add Funds', style: TextStyle(color: white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the current subscription section
  Widget _buildCurrentSubscriptionSection(UserSubscription? subscription) {
    if (subscription == null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'No Current Subscription',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Subscribe to a plan to enjoy premium features!',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Subscription',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                subscription.planName,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Active until: ${DateFormat('yyyy-MM-dd').format(subscription.endDate)}',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                'Amount Paid: ₹${subscription.amountPaid.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  // Add logic to renew subscription
                  // This could open a dialog or navigate to a subscription selection page
                  // For demonstration, we'll show a simple dialog
                  _showRenewSubscriptionDialog;
                },
                child: Text('Renew Subscription'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Shows a dialog to renew the subscription
  void _showRenewSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Renew Subscription'),
        content: Text('Would you like to renew your subscription?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement the renewal logic here
              // For example, navigate to a subscription plans page
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Subscription renewed successfully!')),
              );
            },
            child: Text('Renew'),
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
            ),
          ),
        ],
      ),
    );
  }
}
