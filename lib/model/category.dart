import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  bool isActive;

  Category({
    required this.name,
    required this.icon,
    this.isActive = false,
  });
}
