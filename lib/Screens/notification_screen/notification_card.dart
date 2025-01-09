import 'package:flutter/material.dart';
import 'package:my_urban_care/Screens/common/colors.dart';
import 'package:my_urban_care/provider/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  NotificationCard({required this.notification});

  IconData _getIcon() {
    // Customize icons based on notification type if needed
    return notification.title.contains('Welcome')
        ? Icons.notifications_outlined
        : notification.title.contains('Update')
        ? Icons.system_update
        : Icons.notifications;
  }

  Color _getIconColor() {
    // Customize icon colors based on notification type
    return notification.title.contains('Welcome')
        ? primary
        : notification.title.contains('Update')
        ? secondary
        : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationProvider>(context, listen: false);
    final formattedTime =
    DateFormat('yyyy-MM-dd HH:mm').format(notification.timestamp);

    return Card(
      color: notification.isRead ? Colors.white : Colors.blue[50],
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getIconColor(),
          child: Icon(
            _getIcon(),
            color: Colors.white,
          ),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight:
            notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.description),
            SizedBox(height: 5),
            Text(
              formattedTime,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: notification.title.contains('Welcome')
            ? null
            : IconButton(
          icon: Icon(Icons.reply),
          onPressed: () {
            // Handle reply action
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Reply to ${notification.title}')),
            );
          },
        ),
        onTap: () {
          provider.markAsRead(notification.id);
          // Handle notification tap
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tapped on ${notification.title}')),
          );
        },
      ),
    );
  }
}
