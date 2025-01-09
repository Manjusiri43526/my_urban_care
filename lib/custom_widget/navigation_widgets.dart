import 'package:flutter/material.dart';
import 'package:my_urban_care/Screens/category_screen/category_screen.dart';
import 'package:my_urban_care/Screens/home_screen/home_screen.dart';
import 'package:my_urban_care/Screens/order_screen/order_screen.dart';
import 'package:my_urban_care/Screens/profile_screen/profile_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class BottomNavigation extends StatefulWidget{
  const BottomNavigation({super.key});

  @override
  State<StatefulWidget> createState() {
    return BottomNavigationState();
  }
}

class BottomNavigationState extends State<BottomNavigation>{

  int _selectedIndex = 0;

  final List<Widget> _pages =  [
    HomeScreen(),
    CategoryPage(),
    OrdersPage(),
    ProfilePage(),
  ];

  void _onItemTapped (int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Fixed for more than three items
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
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
    );
  }
}