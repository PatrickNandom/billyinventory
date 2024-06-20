import 'package:billyinventory/models/products_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(Product product) async {
    try {
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
