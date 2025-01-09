import 'package:my_urban_care/model/product_model.dart';

class ProductData {
  static List<Product> getProducts() {
    return [
      Product(
        id: '1',
        category: 'Dry Clean',
        subCategory: 'Men\'s',
        title: 'Shirt',
        image: 'assets/image/svg/shirt.svg',
        price: 5.0,
      ),
      Product(
        id: '2',
        category: 'Dry Clean',
        subCategory: 'Men\'s',
        title: 'T-Shirt',
        image: 'assets/image/svg/t-shirt1.svg',
        price: 3.0,
      ),
      Product(
        id: '3',
        category: 'Dry Clean',
        subCategory: 'Women\'s',
        title: 'Jeans',
        image: 'assets/image/svg/ripped_jeans.svg',
        price: 4.5,
      ),
      // Add more products as needed
      Product(
        id: '4',
        category: 'Laundry',
        subCategory: 'Beddings',
        title: 'Bed Sheet',
        image: 'assets/image/svg/bedsheet.svg',
        price: 10.0,
      ),
      Product(
        id: '5',
        category: 'Iron',
        subCategory: 'Household',
        title: 'Ironing Service',
        image: 'assets/image/svg/clean_clothes.svg',
        price: 2.0,
      ),
      Product(
        id: '6',
        category: 'Folding',
        subCategory: 'Household',
        title: 'Folding Service',
        image: 'assets/image/svg/clean_clothes.svg',
        price: 1.5,
      ),
      // Continue adding as per your requirements
    ];
  }
}
