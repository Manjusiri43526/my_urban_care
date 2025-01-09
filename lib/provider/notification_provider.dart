// lib/providers/notification_provider.dart

import 'package:flutter/material.dart';

enum NotificationFilter { all, mentions, messages, system }

class NotificationItem {
  final String id;
  final String title;
  final String description;
  final DateTime timestamp;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    this.isRead = false,
  });
}

class NotificationProvider with ChangeNotifier {
  List<NotificationItem> _notifications = [
    // Sample notifications
    NotificationItem(
      id: '1',
      title: 'Welcome!',
      description: 'Thanks for joining our platform.',
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
      isRead: false,
    ),
    NotificationItem(
      id: '2',
      title: 'Update Available',
      description: 'Version 2.0 is now available.',
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
      isRead: true,
    ),
    // Add more notifications as needed
  ];

  NotificationFilter _filter = NotificationFilter.all;

  List<NotificationItem> get notifications {
    switch (_filter) {
      case NotificationFilter.all:
        return _notifications;
      case NotificationFilter.mentions:
        return _notifications.where((n) => n.title.contains('Mention')).toList();
      case NotificationFilter.messages:
        return _notifications.where((n) => n.title.contains('Message')).toList();
      case NotificationFilter.system:
        return _notifications.where((n) => n.title.contains('System')).toList();
      default:
        return _notifications;
    }
  }

  NotificationFilter get filter => _filter;

  void setFilter(NotificationFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  void markAllAsRead() {
    for (var notification in _notifications) {
      notification.isRead = true;
    }
    notifyListeners();
  }

  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
      notifyListeners();
    }
  }
}
