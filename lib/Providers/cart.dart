import 'package:flutter/material.dart';
import '../models/product.dart';

class Cart_List with ChangeNotifier {
  List<Product> _cartProducts = [];

  List<Product> get cartProducts => _cartProducts;

  double get total => cartProducts.fold(0, (sum, item) => sum + item.price * item.quantity);

  void addToCart(Product product) {
    //if the product is already in the cart, then we will add 1 to the quantity
    int index = cartProducts.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      cartProducts[index].quantity += 1;
    }
    //else,we add a new product to the cart list.
    else {
      var newProduct = Product(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite,
        quantity: 1,
        category: product.category,
      );
      cartProducts.add(newProduct);
    }
    // After modifying the cart, we calls `notifyListeners` to update listeners.
    notifyListeners();
  }

  void removeFromCart(String productId) {
    cartProducts.removeWhere((p) => p.id == productId);
    notifyListeners();
  }
}
