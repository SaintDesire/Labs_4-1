// import 'package:flutter/material.dart';
// import '../models/product.dart';
//
// class ProductProvider with ChangeNotifier {
//   List<Product> _products = [
//     Product(id: '1', name: 'Product 1', description: 'Description 1', price: 10.0),
//     Product(id: '2', name: 'Product 2', description: 'Description 2', price: 20.0),
//   ];
//
//   List<Product> get products => [..._products];
//
//   void addProduct(Product product) {
//     _products.add(product);
//     notifyListeners();
//   }
//
//   void updateProduct(String id, Product updatedProduct) {
//     final index = _products.indexWhere((prod) => prod.id == id);
//     if (index != -1) {
//       _products[index] = updatedProduct;
//       notifyListeners();
//     }
//   }
//
//   void removeProduct(String id) {
//     _products.removeWhere((product) => product.id == id);
//     notifyListeners();
//   }
// }
