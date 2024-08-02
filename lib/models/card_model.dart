// Model for an item in the cart
class CartItem {
  final String productID;
  final String productName;
  final double sellingPrice;
  final String productImage;
  int quantity;

  CartItem({
    required this.productID,
    required this.productName,
    required this.sellingPrice,
    required this.quantity,
    required this.productImage,
  });

  double get totalPrice => sellingPrice * quantity;
}
