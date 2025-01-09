// bucket_provider.dart
import 'package:flutter/material.dart';
import '../model/product_model.dart';

class BucketProvider with ChangeNotifier {
  final List<Product> _bucket = [];

  List<Product> get bucket => _bucket;

  // Add a product to the bucket or increment its quantity
  void addProduct(Product product) {
    // Check if product already exists in the bucket
    int index = _bucket.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _bucket[index].quantity += 1;
    } else {
      _bucket.add(Product(
        id: product.id,
        category: product.category,
        subCategory: product.subCategory,
        title: product.title,
        image: product.image,
        quantity: 1, // Initialize with quantity = 1
        price: product.price,
      ));
    }
    notifyListeners();
  }

  // Remove a product from the bucket
  void removeProduct(String id) {
    _bucket.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  // Increment the quantity of a product
  void incrementQuantity(String id) {
    int index = _bucket.indexWhere((p) => p.id == id);
    if (index != -1) {
      _bucket[index].quantity += 1;
      notifyListeners();
    } else {
      // If product not in bucket, add it with quantity = 1
      // This requires having access to the product details
      // For simplicity, this case can be handled in ProductTile
    }
  }

  // Decrement the quantity of a product
  void decrementQuantity(String id) {
    int index = _bucket.indexWhere((p) => p.id == id);
    if (index != -1 && _bucket[index].quantity > 1) {
      _bucket[index].quantity -= 1;
      notifyListeners();
    } else if (index != -1 && _bucket[index].quantity == 1) {
      removeProduct(id);
    }
  }

  // Get the quantity of a specific product
  int getQuantity(String id) {
    int index = _bucket.indexWhere((p) => p.id == id);
    if (index != -1) {
      return _bucket[index].quantity;
    }
    return 0;
  }

  // Get all products in the bucket
  List<Product> getBucketProducts() {
    return _bucket;
  }

  // Get the total price of all items in the bucket
  double getTotalPrice() {
    double total = 0.0;
    for (var item in _bucket) {
      total += item.price * item.quantity;
    }
    return total;
  }

  // Clear the entire bucket
  void clearBucket() {
    _bucket.clear();
    notifyListeners();
  }
}
