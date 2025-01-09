import 'dart:async';
import 'package:flutter/material.dart';

class OtpProvider with ChangeNotifier {
  bool isResendEnabled = false;
  int resendCountdown = 30;
  Timer? _timer;

  OtpProvider() {
    _startOtpResendTimer(); // Start the timer when the provider is initialized
  }

  // Start countdown timer
  void _startOtpResendTimer() {
    isResendEnabled = false;
    resendCountdown = 30; // Reset the countdown
    notifyListeners();

    _timer?.cancel(); // Cancel any existing timer before starting a new one
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown > 0) {
        resendCountdown--;
      } else {
        isResendEnabled = true;
        _timer?.cancel(); // Stop the timer when countdown reaches 0
      }
      notifyListeners();
    });
  }

  void resendOtp() {
    if (isResendEnabled) {
      _startOtpResendTimer(); // Restart the timer on resend
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the provider is disposed of
    super.dispose();
  }
}
