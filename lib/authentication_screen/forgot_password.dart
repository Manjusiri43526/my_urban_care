import 'package:flutter/material.dart';
import 'package:my_urban_care/authentication_screen/otp_screen.dart';
import 'package:my_urban_care/custom_widget/custom_alert_box.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 92, left: 20, right: 20),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 26,
                    fontFamily: "Sf Ui Display SemiBold",
                  ),
                ),
                const SizedBox(
                    width: 257,
                    child: Text(
                      "Enter your email account to reset your password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "gill sans",
                          color: Color(0xFF7D848D)),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                        fillColor: Colors.blueGrey.shade50,
                        filled: true,
                        hintText: "Enter your email",
                        hintStyle: const TextStyle(
                            color: Color(0xFF7D848D),
                            fontFamily: "Sf Ui Display medium",
                            fontSize: 16),
                        suffixIcon: const Icon(
                          Icons.email_outlined,
                          color: Color(0xFF7D848D),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 2,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none)),
                  ),
                ),
                SizedBox(
                  width: 335,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Show the alert box first
                      CustomWidgets.customAlertBox(
                        context,
                        "Check your email",
                        "We have sent password recovery instructions to your email",
                      );

                      // Delay for 2-3 seconds before navigating to OTP screen
                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OtpScreen(),
                          ),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Reset Password",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Sf Ui Display medium",
                          color: Colors.white),
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
