// lib/model/product_model.dart

class Product {
  final String id;
  final String category;
  final String subCategory;
  final String title;
  final String image;
  int quantity;
  final double price;

  Product({
    required this.id,
    required this.category,
    required this.subCategory,
    required this.title,
    required this.image,
    this.quantity = 0,
    required this.price,
  });
}
