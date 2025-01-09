import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:my_urban_care/Screens/common/colors.dart';
import 'package:my_urban_care/Screens/home_screen/home_screen.dart';

import '../provider/otp_provider.dart';

class OtpVerificationPage extends StatefulWidget {
  final String mobileNumber;
  final String otp; // Field to receive OTP from the API response

  const OtpVerificationPage({
    Key? key,
    required this.mobileNumber,
    required this.otp,
  }) : super(key: key);

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  // Controller to store the entered OTP
  TextEditingController otpController = TextEditingController();

  bool isLoading = false;

  Future<void> verifyOtp() async {
    setState(() {
      isLoading = true;
    });

    // API URL (replace with your actual API endpoint)
    const String apiUrl = 'https://collegeprojectz.com/urbancare/api/verifyOTP';

    // Prepare the body of the POST request
    final body = {
      'contact_no': widget.mobileNumber,
      'otp': otpController.text, // OTP entered by the user
    };

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print("OTP verification success: ${response.body}");
        // Continue to HomeScreen or success action
      } else {
        print("OTP verification failed: ${response.body}");
        // Handle failure
      }
    } catch (e) {
      print('Network error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OtpProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: const Text(
            "OTP Verification",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  "Enter the OTP sent to ${widget.mobileNumber}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Color(0xFF7D848D),
                      ),
                      hintText: "Enter OTP",
                      hintStyle: const TextStyle(
                        color: Color(0xFF7D848D),
                        fontFamily: "Sf Ui Display medium",
                        fontSize: 16,
                      ),
                      fillColor: Colors.blueGrey.shade50,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          width: 2,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 335,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      "Verify OTP",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Sf Ui Display medium",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Consumer<OtpProvider>(
                  builder: (context, otpProvider, child) {
                    return TextButton(
                      onPressed: otpProvider.isResendEnabled
                          ? () {
                        otpProvider.resendOtp(); // Trigger OTP resend
                      }
                          : null,
                      child: Text(
                        otpProvider.isResendEnabled
                            ? "Resend OTP"
                            : "Resend in ${otpProvider.resendCountdown} seconds",
                        style: TextStyle(
                          color: otpProvider.isResendEnabled
                              ? primary
                              : Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                // Box to display the OTP (for debugging or UI purpose)
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                  child: Text(
                    'OTP: ${widget.otp}', // Display the OTP here
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
