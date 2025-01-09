import 'package:flutter/material.dart';
import 'package:my_urban_care/Screens/category_screen/address_page.dart';
import 'package:my_urban_care/Screens/category_screen/bucket_list_page.dart';
import 'package:my_urban_care/Screens/subscription_page.dart';
import 'package:my_urban_care/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_urban_care/Screens/profile_screen/edit_profile.dart';
import 'package:my_urban_care/Screens/common/colors.dart';

import '../notification_screen/notification_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context).profile;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text(
          'Profile',
          style: TextStyle(color: white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: white,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Welcome Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: profile.profileImage != null
                              ? FileImage(profile.profileImage!)
                              : const AssetImage("assets/images/profile_photo.jpg") as ImageProvider,
                          radius: 25,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Welcome, ${profile.name}!',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    PopupMenuButton<String>(
                      onSelected: (String result) {
                        if (result == 'Edit Profile') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EditProfilePage()),
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return {'Edit Profile'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                      icon: const Icon(Icons.more_vert),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  profile.email,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                Text(
                  profile.number,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Saved Address:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  profile.address,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Options Section
          _buildOptionItem(context, 'Saved Addresses', Icons.location_on_outlined),
          _buildOptionItem(context, 'Subscription', Icons.subscriptions_rounded),
          _buildOptionItem(context, 'Terms and Conditions', Icons.assignment),
          _buildOptionItem(context, 'Support', Icons.question_mark),
          _buildOptionItem(context, 'Logout', Icons.logout),
        ],
      ),
    );
  }

  Widget _buildOptionItem(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        switch (title) {
          case 'Saved Addresses':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AddressPage()),
            );
            break;
          case 'Subscription':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  SubscriptionPage()),
            );
            break;
          case 'Refer and Earn':
          // Navigate to Refer and Earn Page
            break;
          case 'Terms and Conditions':
          // Navigate to Terms and Conditions Page
            break;
          case 'Support':
          // Navigate to Support Page
            break;
          case 'Logout':
            _showLogoutDialog(context);
            break;
          default:
          // Handle unknown options or provide a default action
            print('Tapped on $title');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: primary),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                // Implement logout functionality
                Provider.of<ProfileProvider>(context, listen: false).clearProfile();
                Navigator.of(context).pop();
                print('Logged out');
                // You might want to navigate to a login screen here
              },
            ),
          ],
        );
      },
    );
  }
}
