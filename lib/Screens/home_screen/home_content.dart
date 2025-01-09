// lib/screens/home_screen/home_content.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_urban_care/Screens/category_screen/category_item.dart';
import 'package:my_urban_care/screens/order_screen/order_details_page.dart';
import 'package:my_urban_care/screens/common/colors.dart';
import '../../model/category.dart';
import '../../model/category_info.dart';
import '../../model/order.dart';
import '../../model/order_info.dart';
import '../../provider/home_provider.dart';
import '../../provider/profile_provider.dart';
import '../category_screen/sub_category_screen.dart';
import '../notification_screen/notification_screen.dart';
import '../profile_screen/profile_screen.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final PageController _bannerPageController = PageController();
  int _currentBannerPage = 0;
  late Timer _bannerTimer;

  @override
  void initState() {
    super.initState();

    // Pre-cache asset images
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _precacheAssetImages();
    });

    // Initialize the banner auto-scroll timer
    _bannerTimer = Timer.periodic(const Duration(seconds: 15), (Timer timer) {
      if (_currentBannerPage < 2) {
        _currentBannerPage++;
      } else {
        _currentBannerPage = 0;
      }

      // Animate to the next banner page
      if (_bannerPageController.hasClients) {
        _bannerPageController.animateToPage(
          _currentBannerPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeIn,
        );
      }
    });
  }

  // Helper method to pre-cache asset images
  void _precacheAssetImages() {
    List<String> assetImages = [
      'assets/image/png/banner1.jpg',
      'assets/image/png/banner2.jpg',
      'assets/image/png/banner3.jpg',
      // Add other asset images if any
    ];

    for (String path in assetImages) {
      precacheImage(AssetImage(path), context);
    }
  }

  @override
  void dispose() {
    _bannerTimer.cancel();
    _bannerPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context).profile;
    final homeProvider = Provider.of<HomeProvider>(context);

    return SingleChildScrollView(
      // Allows the entire content to scroll
      child: Column(
        children: [
        Stack(
        clipBehavior: Clip.none,
        children: [
          // Upper Container with Gradient Background
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primary,
                  primary.withOpacity(0.3),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding:
              const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile, Shopping Bag, and Notification Icons at the Top
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Profile Icon
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilePage(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundImage: profile.profileImage != null
                              ? FileImage(profile.profileImage!)
                              : const AssetImage(
                              "assets/images/profile_photo.jpg")
                          as ImageProvider,
                          radius: 25,
                        ),
                      ),
                      Row(
                        children: [
                          // Shopping Bag Icon
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.shopping_bag,
                              color: secondary,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 20),
                          // Notification Icon
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NotificationPage(),
                                ),
                              );
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(
                                Icons.notifications,
                                color: secondary,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Text Content
                  RichText(
                    text: const TextSpan(
                      text: 'Discover the Next Evolution of ',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Laundry',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Banner Container Positioned Below the Upper Container
          Positioned(
            top: 230,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: Container(
              width: double.infinity, // 80% of the screen width
              height: 150, // 150px height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset:
                    const Offset(0, 3), // Shadow positioning
                  ),
                ],
              ),
              child: PageView(
                controller: _bannerPageController,
                children: <Widget>[
                  // First Banner
                  _buildBannerPage(
                    imagePath: 'assets/image/png/banner1.jpg',
                    title: 'Explore Nature',
                    subtitle: 'Discover the beauty of the outdoors',
                  ),
                  // Second Banner
                  _buildBannerPage(
                    imagePath: 'assets/image/png/banner2.jpg',
                    title: 'Find Peace',
                    subtitle: 'Relax and rejuvenate with our services',
                  ),
                  // Third Banner
                  _buildBannerPage(
                    imagePath: 'assets/image/png/banner3.jpg',
                    title: 'Adventure Awaits',
                    subtitle: 'Embark on thrilling new experiences',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 120), // Adjusted for the Positioned banner
      // Active Orders Section
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Section
            const Text(
              'Category',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Category List
            SizedBox(
              height: 95,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  bool isActive =
                      homeProvider.activeCategoryIndex == index;
                  Category category = categories[index];
                  return CategoryItem(
                    category: category,
                    isActive: isActive,
                    onTap: () {
                      homeProvider.setActiveCategoryIndex(index);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoryPage(categoryTitle: category.name,),));
                      // Optionally, navigate to category details
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            // Two Additional Static Banners in a Row
            SizedBox(
              height: 100, // Fixed height for static banners
              child: Row(
                children: [
                  // First Static Banner
                  Expanded(
                    child: _buildStaticBanner(
                      imagePath:
                      'https://i.pinimg.com/736x/33/6d/6f/336d6f0ea27371b098347c324916b6d8.jpg',
                      title: 'Premium Services',
                    ),
                  ),
                  const SizedBox(width: 16), // Spacing between banners
                  // Second Static Banner
                  Expanded(
                    child: _buildStaticBanner(
                      imagePath:
                      'https://i.pinimg.com/736x/c8/ea/62/c8ea62c9fe40ec356643e14f02a1480a.jpg',
                      title: 'Iron Perfection',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Active Orders Section
            const Text(
              "Active Orders",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            // List of Active Orders
            ListView.builder(
              shrinkWrap: true, // Allows ListView inside SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final Order order = orders[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to OrderDetailsPage with the selected order
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsPage(order: order),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        bottom: 8, left: 16, right: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Order ID and Date of Pickup
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order ID: #${order.orderNumber ?? "N/A"}', // Handle null
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              order.dateOfPickup ?? "N/A", // Handle null
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF7D848D),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Quantity and Price
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            // Quantity
                            Row(
                              children: [
                                const Icon(
                                  Icons.local_laundry_service,
                                  color: primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${order.quantity} Items',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF7D848D),
                                  ),
                                ),
                              ],
                            ),
                            // Price
                            Row(
                              children: [
                                const Icon(
                                  Icons.currency_rupee,
                                  color: primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${order.price.toStringAsFixed(2)}', // Assuming price is not null
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF7D848D),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
        ],
      ),
    );
  }

  // Helper method to build each banner page for the main banner
  Widget _buildBannerPage({
    required String imagePath,
    required String title,
    required String subtitle,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Text Overlay
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build static banners
  Widget _buildStaticBanner({
    required String imagePath,
    required String title,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.network(
            imagePath,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return const Center(
                child: Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 50,
                ),
              );
            },
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Text Overlay
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
