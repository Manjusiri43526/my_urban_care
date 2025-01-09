// lib/model/wallet.dart

class Wallet {
  double balance;
  List<Transaction> transactions;

  Wallet({
    required this.balance,
    required this.transactions,
  });
}

class Transaction {
  final String id;
  final String description;
  final double amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });
}
