import 'package:flutter/material.dart';
import 'package:my_urban_care/Screens/common/colors.dart';
import '../../model/category.dart'; // Ensure this model includes necessary fields

class CategoryItem extends StatelessWidget {
  final Category category;
  final bool isActive;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.category,
    this.isActive = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 95,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isActive ? primary : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category.icon,
              size: 36,
              color: isActive ? Colors.white : secondary,
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              style: TextStyle(
                color: isActive ? Colors.white : secondary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
