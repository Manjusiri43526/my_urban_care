import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Screens/common/colors.dart';
import '../authentication_screen/signin_screen.dart';
import '../model/onboarding_item.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int _currentPage = 0;
  final controller = OnboardingItems();
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    // Pre-cache images after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var item in controller.items) {
        precacheImage(AssetImage(item.logo), context);
        precacheImage(AssetImage(item.image), context);
      }
    });
  }

  // Next page method
  void _nextPage() {
    if (_currentPage < controller.items.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0, // Remove shadow
        actions: [
          if (_currentPage < controller.items.length - 1)
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  fontSize: 18,
                  color: secondary,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: controller.items.length,
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final item = controller.items[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        item.logo,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Image.asset(
                        item.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SmoothPageIndicator(
                      controller: pageController,
                      count: controller.items.length,
                      effect: const WormEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        activeDotColor: primary,
                      ),
                      onDotClicked: (index) => pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  _currentPage == controller.items.length - 1 ? 'Get Started' : 'Next',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
