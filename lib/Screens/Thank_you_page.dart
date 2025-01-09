// lib/screens/thank_you_page.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_urban_care/Screens/category_screen/category_screen.dart';
import 'package:my_urban_care/Screens/home_screen/home_screen.dart';
import 'common/colors.dart';

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use Scaffold to create a standard page structure
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thank You!',
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primary,
        centerTitle: true,
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 100,
                color: primary,
              ),
              const SizedBox(height: 20),
              const Text(
                'Your order has been placed successfully!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to home or another relevant screen
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: const Text(
                  'Continue Shopping',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
