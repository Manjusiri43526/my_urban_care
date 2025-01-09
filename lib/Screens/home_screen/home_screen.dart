// lib/screens/home_screen/home_screen.dart

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:my_urban_care/screens/common/colors.dart';
import 'package:my_urban_care/screens/home_screen/home_content.dart';
import 'package:my_urban_care/screens/order_screen/order_screen.dart';
import 'package:my_urban_care/screens/profile_screen/profile_screen.dart';

import '../../provider/home_provider.dart';
import '../../provider/profile_provider.dart';
import '../category_screen/category_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  // List of pages for navigation
  final List<Widget> _pages =  [
    HomeContent(),
    CategoryPage(),
    OrdersPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // Access HomeProvider
    final homeProvider = Provider.of<HomeProvider>(context);
    final profile = Provider.of<ProfileProvider>(context).profile;

    return Scaffold(
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Fixed for more than three items
        currentIndex: homeProvider.selectedIndex,
        onTap: (index) {
          homeProvider.setSelectedIndex(index);
        },
        backgroundColor: Colors.white,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle:
        const TextStyle(fontWeight: FontWeight.normal),
        items:  [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.homeOutline),
            activeIcon: Icon(MdiIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.bagCarryOn),
            activeIcon: Icon(MdiIcons.bagCarryOnOff),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.clipboardTextOutline),
            activeIcon: Icon(MdiIcons.clipboardText),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.accountOutline),
            activeIcon: Icon(MdiIcons.account),
            label: 'Profile',
          ),
        ],
      ),
      // Body of the Scaffold shows the selected page
      body: _pages[homeProvider.selectedIndex],
    );
  }
}
