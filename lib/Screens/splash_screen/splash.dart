import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_urban_care/Screens/common/colors.dart';
import 'package:my_urban_care/onboarding/onboarding_page.dart'; // Ensure this exists and is imported correctly

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const OnBoardingPage();
      },));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color:white,
      child: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(
              "assets/image/png/urban_logo.png"),
        ),
      ),
    );
  }
}
