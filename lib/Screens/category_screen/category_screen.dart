// lib/screens/category_screen/category_page.dart

import 'package:flutter/material.dart';
import 'package:my_urban_care/Screens/category_screen/category_item.dart';
import 'package:provider/provider.dart';
import '../../provider/bucket_provider.dart';
import '../common/colors.dart';
import 'bucket_list_page.dart';
import 'sub_category_screen.dart';
import '../../model/category.dart'; // Ensure the Category model is defined

class CategoryPage extends StatelessWidget {
  // Assuming you have a predefined list of Category objects
  final List<Category> categories = [
    Category(name: 'Dry Clean', icon: Icons.cleaning_services),
    Category(name: 'Laundry', icon: Icons.local_laundry_service),
    Category(name: 'Iron', icon: Icons.iron),
    Category(name: 'Folding', icon: Icons.folder_delete_sharp),
    // Add more categories as needed
  ];

  CategoryPage({Key? key}) : super(key: key); // Add Key if necessary

  @override
  Widget build(BuildContext context) {
    final bucketProvider = Provider.of<BucketProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Categories',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primary,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: white,
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BucketListPage()),
                  );
                },
              ),
              if (bucketProvider.bucket.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${bucketProvider.bucket.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns
            childAspectRatio: 3 / 2, // Adjust as needed
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return CategoryItem(
              category: category,
              isActive: false, // Or set based on some condition
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubCategoryPage(
                      categoryTitle: category.name,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
