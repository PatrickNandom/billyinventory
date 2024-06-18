import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String productId;
  final String productName;
  final String productImage;
  final String description;
  final String category;
  final double costPrice;
  final double sellingPrice;
  final int quantity;
  final DateTime createdAt;

  Product({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.description,
    required this.category,
    required this.costPrice,
    required this.sellingPrice,
    required this.quantity,
    required this.createdAt,
  });

  static Product fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Product(
      productId: snapshot["productId"],
      productName: snapshot["productName"],
      productImage: snapshot["productImage"],
      description: snapshot["description"],
      category: snapshot["category"],
      costPrice: snapshot["costPrice"],
      sellingPrice: snapshot["sellingPrice"],
      quantity: snapshot["quantity"],
      createdAt: snapshot["createdAt"],
    );
  }

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "productImage": productImage,
        "description": description,
        "category": category,
        "costPrice": costPrice,
        "sellingPrice": sellingPrice,
        "quantity": quantity,
        "createdAt": createdAt,
      };
}
