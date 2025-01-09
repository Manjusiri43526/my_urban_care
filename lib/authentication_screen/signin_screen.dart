import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:my_urban_care/Screens/common/colors.dart';
import 'package:my_urban_care/authentication_screen/otp_verification_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For decoding JSON responses


class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignInPageState();
  }
}

class SignInPageState extends State<SignInPage> {
  String mobileNumber = "";
  String countryCode = "+91"; // Default country code

  // Function to send OTP using API
  // Function to send OTP using API
  Future<void> sendOtp(String fullPhoneNumber) async {
    final url = Uri.parse('https://collegeprojectz.com/urbancare/api/sendOTP');
    final requestBody = {
      "contact_no": fullPhoneNumber,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("OTP sent successfully, response data: $responseData");

        // Convert OTP to a string
        String otp = responseData['otp'].toString();  // Convert int OTP to string

        // Navigate to OTP verification screen with mobile number and OTP
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return OtpVerificationPage(
                mobileNumber: fullPhoneNumber,
                otp: otp, // Pass the OTP as a string
              );
            },
          ),
        );
      } else {
        print("Failed to send OTP, response code: ${response.statusCode}");
        print("Response body: ${response.body}");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send OTP. Error: ${response.body}'),
          ),
        );
      }
    } catch (error) {
      print("Error occurred: $error");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false, // Remove the default back button
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset('assets/image/png/urban_logo.png'),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Welcome Back!",
                      style: TextStyle(
                        letterSpacing: 3,
                        color: primary,
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Sf Ui Display SemiBold",
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Please enter your mobile number",
                      style: TextStyle(
                        fontFamily: "gill sans",
                        fontSize: 16,
                        color: Color(0xFF7D848D),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: IntlPhoneField(
                    initialCountryCode: 'IN',
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      fillColor: Colors.blueGrey.shade50,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (phone) {
                      // print(phone);

                      setState(() {
                        mobileNumber = phone.number.toString();
                        countryCode = phone.countryCode;

                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 335,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (mobileNumber.isNotEmpty) {
                        final fullPhoneNumber = '$mobileNumber';
                        // Call the API to send OTP
                        sendOtp(fullPhoneNumber);
                        // print(fullPhoneNumber);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter your mobile number'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Send OTP",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Sf Ui Display medium",
                        color: Colors.white,
                      ),
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
