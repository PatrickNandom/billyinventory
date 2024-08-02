// import 'package:billyinventory/models/products_model.dart';
// import 'package:billyinventory/providers/card_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void showAddToCartDialog(BuildContext context, Product product) {
//   final TextEditingController _quantityController = TextEditingController();
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text('Add ${product.productName} to Cart'),
//         content: TextField(
//           controller: _quantityController,
//           keyboardType: TextInputType.number,
//           decoration: const InputDecoration(
//             labelText: 'Quantity',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               final int quantity = int.tryParse(_quantityController.text) ?? 1;
//               Provider.of<CartProvider>(context, listen: false).addItem(
//                 product.productId,
//                 product.productName,
//                 product.sellingPrice,
//                 product.productImage,
//                 quantity: quantity,
//               );
//               Navigator.of(context).pop();
//             },
//             child: const Text('Add to Cart'),
//           ),
//         ],
//       );
//     },
//   );
// }
