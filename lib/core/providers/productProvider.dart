import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({required this.id,required this.name, required this.description, required this.price, required this.imageUrl});

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      price: (data['price'] is String)
          ? double.tryParse(data['price']) ?? 0.0
          : data['price']?.toDouble() ?? 0.0,
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

}


class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void clearProducts() {
    _products.clear();
    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.removeAt(_products.lastIndexOf(product));
    notifyListeners();
  }

  int getProductCount(Product product) {
    return _products.where((p) => p == product).length;
  }

  double getBuyCount() {
    late double totalPrice = 0;
    _products.forEach((product) {
      totalPrice = product.price + totalPrice;
    });
    return totalPrice;
  }

}