import 'package:cloth_ecommerce_application/model/product_model.dart';
import 'package:cloth_ecommerce_application/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final List<ProductModel> _items = ProductModel.sampleProductData;
  final List<ProductModel> _cart = [];
  final List<ProductModel> _favourites = [];

  List<ProductModel> get items => _items;
  List<ProductModel> get favourite => _favourites;
  List<ProductModel> get cart => _cart;

  //cart
  void addToCart(ProductModel product) {
    _cart.add(product.copyWith(quantity: 1));
    notifyListeners();
  }

  void increseQuanitity(int id, int maxStock) {
    int index = _cart.indexWhere((element) => element.id == id);
    if (index == -1) return;
    if (_cart[index].quantity < maxStock) {
      _cart[index] = _cart[index].copyWith(quantity: _cart[index].quantity + 1);
    } else {
      failedSnackBar(text: "Stock limit reached");
    }
    notifyListeners();
  }

  void decreaseQuanitity(int id) {
    final index = _cart.indexWhere((element) => element.id == id);
    if (_cart[index].quantity == 1) return;
    _cart[index] = _cart[index].copyWith(quantity: _cart[index].quantity - 1);

    notifyListeners();
  }

  void removeCart(int id) {
    _cart.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    for (var element in _cart) {
      total += element.price * element.quantity;
    }
    return total;
  }

  //favourites

  void addToFavourites(ProductModel product) {
    if (!_favourites.contains(product)) {
      _favourites.add(product);
      notifyListeners();
    }
  }

  void removeFromFavourites(int id) {
    _favourites.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  bool isFavCheck(int id) {
    return _favourites.any((product) => product.id == id);
  }
}
