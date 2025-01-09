import 'package:flutter/material.dart';
import 'package:my_urban_care/Screens/category_screen/sub_category_listtile.dart';
import 'package:my_urban_care/model/product_info.dart';
import 'package:my_urban_care/model/product_model.dart';
import 'package:my_urban_care/provider/bucket_provider.dart';
import 'package:provider/provider.dart';
import '../common/colors.dart';
import 'bucket_list_page.dart';

class SubCategoryPage extends StatefulWidget {
  final String categoryTitle;

  SubCategoryPage({required this.categoryTitle});

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  String? selectedSubCategory;
  List<String> subCategories = [
    'Men\'s',
    'Women\'s',
    'Beddings',
    'Household',
    'Kids',
    'Delicates'
  ];

  late List<Product> products;

  @override
  void initState() {
    super.initState();
    products = ProductData.getProducts()
        .where((p) => p.category == widget.categoryTitle)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // Filter products based on selected subcategory
    List<Product> filteredProducts = selectedSubCategory == null
        ? products
        : products
        .where((p) => p.subCategory == selectedSubCategory)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('${widget.categoryTitle} Services',style: const TextStyle(color: white,fontWeight: FontWeight.bold),),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: white,
        ),
        actions: [
          Consumer<BucketProvider>(
            builder: (_, bucket, __) => Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BucketListPage()),
                    );
                  },
                ),
                if (bucket.bucket.length > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${bucket.bucket.length}',
                        style: TextStyle(
                          color: white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Subcategories at the top
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: subCategories.length,
              itemBuilder: (context, index) {
                final sub = subCategories[index];
                bool isSelected = selectedSubCategory == sub;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedSubCategory == sub) {
                        selectedSubCategory = null; // Deselect if already selected
                      } else {
                        selectedSubCategory = sub;
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? primary : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: secondary,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        sub,
                        style: TextStyle(
                          color: isSelected ? white : black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Product List
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.grey.shade200,
                      offset: Offset(0, 2))
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: filteredProducts.isEmpty
                  ? Center(child: Text('No products available'))
                  : ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ProductTile(product: product);
                },
              ),
            ),
          ),
          // Add to Bucket Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // This button can be used to confirm adding selected products
                // However, since we're managing quantities directly, it can be optional
                // For demonstration, we'll show a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Products added to bucket')),
                );
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BucketListPage();
                },));
              },
              child: Text('Add to Bucket',style: TextStyle(fontWeight: FontWeight.bold,color: white),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
