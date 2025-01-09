// widgets/auto_scrolling_banner.dart
import 'dart:async';
import 'package:flutter/material.dart';

class BannerData {
  final String imagePath;
  final String title;

  BannerData({
    required this.imagePath,
    required this.title,
  });
}

class AutoScrollingBanner extends StatefulWidget {
  final List<BannerData> banners;
  final double height;
  final double width;
  final double horizontalMargin;

  const AutoScrollingBanner({
    Key? key,
    required this.banners,
    this.height = 150,
    this.width = double.infinity,
    this.horizontalMargin = 0.0,
  }) : super(key: key);

  @override
  _AutoScrollingBannerState createState() => _AutoScrollingBannerState();
}

class _AutoScrollingBannerState extends State<AutoScrollingBanner> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < widget.banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildBannerPage(BannerData banner) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15), // Adjusted for smaller banners
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.network(
            banner.imagePath,
            fit: BoxFit.cover,
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Text Overlay
          Padding(
            padding: const EdgeInsets.all(8.0), // Reduced padding for smaller banners
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  banner.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14, // Adjusted font size for smaller banners
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.banners.length,
        itemBuilder: (context, index) {
          return _buildBannerPage(widget.banners[index]);
        },
      ),
    );
  }
}
