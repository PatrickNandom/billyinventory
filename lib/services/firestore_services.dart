import 'package:billyinventory/models/products_model.dart';
import 'package:billyinventory/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(
    String productId,
    String productName,
    Uint8List file,
    String description,
    String categiry,
    double costPrice,
    double sellingPrice,
    int quntity,
  ) async {
    try {
      String productId = Uuid().v4();
      String imagePath = 'products/$productId';
      String imageUrl = await FirebaseStorageService()
          .uploadImage(file, 'Product Image $imagePath');
      Product product = Product(
        productId: productId,
        productName: productName,
        productImage: imageUrl,
        description: description,
        category: categiry,
        costPrice: costPrice,
        sellingPrice: sellingPrice,
        quantity: quntity,
        createdAt: DateTime.now(),
      );
      await _firestore
          .collection('products')
          .doc(product.productId)
          .set(product.toJson());
    } catch (e) {
      throw Exception('Error adding product: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _firestore
          .collection('products')
          .doc(product.productId)
          .update(product.toJson());
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}
