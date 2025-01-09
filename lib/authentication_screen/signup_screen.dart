import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:my_urban_care/Screens/common/colors.dart';
import 'package:my_urban_care/Screens/home_screen/home_screen.dart';
import 'package:my_urban_care/authentication_screen/signin_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {
  String mobileNumber = "";
  String countryCode = "+91";  // Default country code

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: primary,
                  width: 3,
                )),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.question_mark,
                  color: primary,
                )),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: 70,
                  height: 100,
                  child: Image.asset('assets/image/png/urban_logo.png')),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Create an account",
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
              const SizedBox(
                height: 30,
              ),

              /// Mobile number field with country code selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IntlPhoneField(
                  initialCountryCode: 'IN',  // Default country
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
                    setState(() {
                      mobileNumber = phone.number;
                      countryCode = phone.countryCode;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const Text(
                    'Remember me',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 335,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Combine the country code and phone number
                    final fullPhoneNumber = '$countryCode$mobileNumber';
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return const HomeScreen();
                      },
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Sf Ui Display medium",
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Sf Ui Display medium",
                        color: Color(0xFF707B81)),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const SignInPage();
                          },
                        ));
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          fontFamily: "Sf Ui Display medium",
                          fontSize: 14,
                          color: secondary,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
