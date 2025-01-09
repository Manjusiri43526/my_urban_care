// lib/providers/checkout_provider.dart

import 'package:flutter/material.dart';

enum PaymentMethod { CashOnDelivery, Wallet, Online }

class CheckoutProvider with ChangeNotifier {
  DateTime? _selectedDate;
  PaymentMethod _selectedPaymentMethod = PaymentMethod.CashOnDelivery;

  DateTime? get selectedDate => _selectedDate;
  PaymentMethod get selectedPaymentMethod => _selectedPaymentMethod;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setPaymentMethod(PaymentMethod method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }


  bool _wantGSTBill = false;

  bool get wantGSTBill => _wantGSTBill;

  void setGSTBill(bool value) {
    _wantGSTBill = value;
    notifyListeners();
  }

  double _discount = 0.0;

  // Apply discount based on coupon code
  void applyDiscount(double discountPercentage) {
    _discount = discountPercentage;
    notifyListeners();
  }

  double get discount => _discount;

  // Calculate the final price after applying the discount
  double getFinalPrice(double totalPrice) {
    return totalPrice - (totalPrice * _discount);
  }


  void applyCoupon(String couponCode) {
    if (couponCode == 'DISCOUNT10') {
      _discount = 10; // 10% discount
      notifyListeners();
    } else {
      _discount = 0;
      notifyListeners();
    }
  }

  double calculateTotal(double subtotal, double gst) {
    return subtotal - _discount + gst;
  }


  double? _couponDiscount;

  double? get couponDiscount => _couponDiscount;

  set couponDiscount(double? value) {
    _couponDiscount = value;
    notifyListeners();
  }


}
