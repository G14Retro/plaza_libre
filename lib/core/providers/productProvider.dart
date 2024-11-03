import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;
  final int price;
  final String imageUrl;

  Product(this.name, this.description, this.price, this.imageUrl);
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
}