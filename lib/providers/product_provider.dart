import 'package:cloth_ecommerce_application/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  //values
  final Map<dynamic, ProductModel> _items = {};
  final Map<dynamic, ProductModel> _favourites = {};

  Map<dynamic, ProductModel> get items => _items;
  Map<dynamic, ProductModel> get favourites => _favourites;

  //get item length
  int get itemCount => _items.length;

  //total price
  double get totalPrice {
    return _items.values.fold(0, (sum, item) {
      double finalPrice =
          item.isOnSale
              ? item.price * (1 - item.discountPercentage / 100)
              : item.price;
      return sum += finalPrice;
    });
  }

  //add product
  void addProduct(ProductModel product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity += 1;
    } else {
      _items[product.id] = product;
    }
    notifyListeners();
  }

  //remove from cart
  void removeProductfromCart(ProductModel product) {
    _items.remove(product.id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void addToFavourites(ProductModel product) {
    if (!_favourites.containsKey(product.id)) {
      _favourites[product.id] = product;
    }
    notifyListeners();
  }

  void removeFromFavourites(String productID) {
    _favourites.remove(productID);
    notifyListeners();
  }

  bool isFavouriteCheck(String productId) {
    return _favourites.containsKey(productId);
  }
}
