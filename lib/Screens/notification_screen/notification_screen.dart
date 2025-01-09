// lib/screens/notification_page.dart

import 'package:flutter/material.dart';
import 'package:my_urban_care/Screens/common/colors.dart';
import 'package:provider/provider.dart';
import '../../provider/notification_provider.dart';
import 'notification_card.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationProvider>(context);
    final notifications = provider.notifications;

    return DefaultTabController(
      length: 4, // All, Mentions, Messages, System
      initialIndex: provider.filter.index,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: Text('Notifications',style: TextStyle(color: white,fontWeight: FontWeight.bold),),
          actions: [
            IconButton(
              icon: Icon(Icons.mark_email_read,color: white,),
              tooltip: 'Mark all as read',
              onPressed: () {
                provider.markAllAsRead();
              },
            ),
            IconButton(
              icon: Icon(Icons.clear_all,color: white),
              tooltip: 'Clear all',
              onPressed: () {
                _showClearAllConfirmation(context, provider);
              },
            ),
          ],
          bottom: TabBar(
            onTap: (index) {
              provider.setFilter(NotificationFilter.values[index]);
            },
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Mentions'),
              Tab(text: 'Messages'),
              Tab(text: 'System'),
            ],
            labelColor: Colors.white,               // Color of selected tab text
            unselectedLabelColor: Colors.grey.shade100,     // Color of unselected tab text
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,         // Custom style for selected tab text
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14,                        // Custom style for unselected tab text
              fontWeight: FontWeight.normal,
            ),
            indicatorColor: secondary,           // Color of the tab indicator (underline)
            indicatorWeight: 3.0,                  // Thickness of the indicator
          ),


        ),
        body: notifications.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return NotificationCard(notification: notifications[index]);
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 20),
          Text(
            'No new notifications',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void _showClearAllConfirmation(
      BuildContext context, NotificationProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Clear All Notifications'),
        content: Text('Are you sure you want to clear all notifications?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              provider.clearAll();
              Navigator.of(ctx).pop();
            },
            child: Text(
              'Clear All',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
