// lib/provider/wallet_provider.dart

import 'package:flutter/material.dart';
import '../model/wallet_model.dart';

class WalletProvider with ChangeNotifier {
  Wallet _wallet = Wallet(balance: 1000.00, transactions: []);

  Wallet get wallet => _wallet;

  void addFunds(double amount) {
    _wallet.balance += amount;
    _wallet.transactions.insert(
      0,
      Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        amount: amount,
        description: 'Added Funds',
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void deductFunds(double amount) {
    if (_wallet.balance >= amount) {
      _wallet.balance -= amount;
      _wallet.transactions.insert(
        0,
        Transaction(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          amount: -amount,
          description: 'Deducted Funds',
          date: DateTime.now(),
        ),
      );
      notifyListeners();
    }
  }

  void refreshWallet() {
    // Implement refresh logic if needed (e.g., fetch from backend)
    notifyListeners();
  }
}
