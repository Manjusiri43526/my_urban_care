import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../provider/wallet_provider.dart';
import 'common/colors.dart';

class TransactionHistoryPage extends StatelessWidget {
  static const routeName = '/transaction-history';

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    final transactions = walletProvider.wallet.transactions;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction History',
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: white),
        centerTitle: true,
        backgroundColor: primary,
      ),
      body: transactions.isEmpty
          ? Center(
        child: Text(
          'No transactions yet.',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final txn = transactions[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: txn.amount > 0
                  ? Icon(Icons.arrow_downward, color: Colors.green)
                  : Icon(Icons.arrow_upward, color: Colors.red),
              title: Text(txn.description),
              subtitle: Text(
                DateFormat('yyyy-MM-dd hh:mm a').format(txn.date),
              ),
              trailing: Text(
                txn.amount > 0
                    ? '+ ₹${txn.amount.toStringAsFixed(2)}'
                    : '- ₹${txn.amount.abs().toStringAsFixed(2)}',
                style: TextStyle(
                  color: txn.amount > 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
