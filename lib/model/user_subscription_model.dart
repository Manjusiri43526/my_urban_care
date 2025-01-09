
class UserSubscription {
  final String planId;
  final String planName;
  final double amountPaid;
  final DateTime startDate;
  final DateTime endDate;

  UserSubscription({
    required this.planId,
    required this.planName,
    required this.amountPaid,
    required this.startDate,
    required this.endDate,
  });
}
