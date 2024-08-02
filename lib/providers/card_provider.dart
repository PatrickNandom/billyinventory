import 'package:billyinventory/models/card_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  // Add item to cart with quantity
  void addItem(String productID, String productName, double sellingPrice,
      String productImage,
      {int quantity = 1}) {
    if (_items.containsKey(productID)) {
      _items.update(
        productID,
        (existingCartItem) => CartItem(
          productID: existingCartItem.productID,
          productName: existingCartItem.productName,
          sellingPrice: existingCartItem.sellingPrice,
          quantity: existingCartItem.quantity + quantity,
          productImage: existingCartItem.productImage,
        ),
      );
    } else {
      _items.putIfAbsent(
        productID,
        () => CartItem(
          productID: productID,
          productName: productName,
          sellingPrice: sellingPrice,
          quantity: quantity,
          productImage: productImage,
        ),
      );
    }
    notifyListeners();
  }

  // Remove item from cart
  void removeItem(String productID) {
    if (_items.containsKey(productID)) {
      _items.remove(productID);
      notifyListeners();
    }
  }

  void incrementQuantity(String productID) {
    if (_items.containsKey(productID)) {
      _items.update(
        productID,
        (existingCartItem) => CartItem(
          productID: existingCartItem.productID,
          productName: existingCartItem.productName,
          sellingPrice: existingCartItem.sellingPrice,
          quantity: existingCartItem.quantity + 1,
          productImage: existingCartItem.productImage,
        ),
      );
      notifyListeners();
    }
  }

  // Decrement the quantity of an item
  void decrementQuantity(String productID) {
    if (_items.containsKey(productID) && _items[productID]!.quantity > 1) {
      _items.update(
        productID,
        (existingCartItem) => CartItem(
          productID: existingCartItem.productID,
          productName: existingCartItem.productName,
          sellingPrice: existingCartItem.sellingPrice,
          quantity: existingCartItem.quantity - 1,
          productImage: existingCartItem.productImage,
        ),
      );
      notifyListeners();
    } else {
      removeItem(productID);
    }
  }

  // Clear the cart
  void clearCart() {
    _items = {};
    notifyListeners();
  }

  // Calculate total amount in the cart
  double get totalAmount {
    double total = 0.0;
    _items.forEach(
      (key, cartItem) {
        total += cartItem.totalPrice;
      },
    );
    return total;
  }

  // Simulate recording sale
  // void recordSale() {
  //   _items.clear();
  //   notifyListeners();
  // }
}
