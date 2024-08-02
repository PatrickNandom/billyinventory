import 'package:cloud_firestore/cloud_firestore.dart';

class Sales {
  final String saleId;
  final String productId;
  final String quantitySold;
  final double totalPrice;
  final String empId;
  final String empName;
  final DateTime salesDate;

  Sales({
    required this.saleId,
    required this.productId,
    required this.quantitySold,
    required this.totalPrice,
    required this.empId,
    required this.empName,
    required this.salesDate,
  });

  static Sales fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Sales(
      saleId: snapshot["saleId"],
      productId: snapshot["productId"],
      quantitySold: snapshot["quantitySold"],
      totalPrice: snapshot["totalPrice"],
      empId: snapshot["empId"],
      empName: snapshot["empName"],
      salesDate: snapshot["salesDate"],
    );
  }

  Map<String, dynamic> toJson() => {
        "saleId": saleId,
        "productId": productId,
        "quantitySold": quantitySold,
        "totalPrice": totalPrice,
        "empId": empId,
        "empName": empName,
        "salesDate": salesDate,
      };
}

/*
import 'package:billyinventory/providers/card_provider.dart';
import 'package:billyinventory/models/sales_model.dart';
import 'package:billyinventory/models/product_model.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeCardScreen extends StatefulWidget {
  const EmployeeCardScreen({super.key});

  @override
  State<EmployeeCardScreen> createState() => _EmployeeCardScreenState();
}

class _EmployeeCardScreenState extends State<EmployeeCardScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to get formatted current date
  String getCurrentFormattedDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE dd MMMM').format(now);
    return 'Today $formattedDate';
  }

  // Function to handle the approval and update records
  Future<void> _handleApproval() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final cartItems = cartProvider.items.values.toList();
    final user = _auth.currentUser;

    if (user == null) return;

    final empId = user.uid; // Employee ID from FirebaseAuth
    final empName = user.displayName ?? 'Unknown'; // Employee name from FirebaseAuth

    try {
      for (final item in cartItems) {
        // Create a new sales record
        final salesId = Uuid().v4(); // Generate unique ID for the sale
        final sale = Sales(
          saleId: salesId,
          productId: item.productID,
          quantitySold: item.quantity.toString(),
          totalPrice: item.totalPrice,
          empId: empId,
          empName: empName,
          salesDate: DateTime.now(),
        );

        await _firestore.collection('sales').doc(salesId).set(sale.toJson());

        // Update product quantity
        final productRef = _firestore.collection('products').doc(item.productID);
        final productSnap = await productRef.get();
        final product = Product.fromSnap(productSnap);
        
        final newQuantity = product.quantity - item.quantity;

        if (newQuantity < 0) {
          throw Exception('Insufficient quantity for product ${item.productName}');
        }

        await productRef.update({'quantity': newQuantity});
      }

      // Clear the cart after processing
      cartProvider.clearCart();
    } catch (e) {
      print('Error processing sale: $e');
      // Handle errors (e.g., show a snackbar or dialog)
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items.values.toList();

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomButtonGlobal(
                      function: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/emplyeedashboard');
                      },
                      width: 100,
                      height: 45,
                      name: 'Back',
                      widgetName: Icon(Icons.arrow_back),
                      btnTextColor: Colors.black,
                    ),
                    SizedBox(width: 45.0),
                    Text(
                      'Purchase Details',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: Colors.grey[800]),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                Text(
                  'ITEMS IN YOUR CART',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 132.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                          color: borderBlueColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: Text(
                            'WAITING TO BE PAID',
                            style: TextStyle(
                                fontSize: 12.0,
                                color: whiteColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(getCurrentFormattedDate()),
                      Divider(color: Colors.black),
                      SizedBox(height: 10.0),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return EmployeeProductCard(
                            productName: item.productName,
                            productImage: item.productImage,
                            price: item.sellingPrice.toString(),
                            quantity: item.quantity.toString(),
                            onAdd: () {
                              cartProvider.incrementQuantity(item.productID);
                            },
                            onRemove: () {
                              cartProvider.decrementQuantity(item.productID);
                            },
                            onDelete: () {
                              cartProvider.removeItem(item.productID);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  'PAYMENT SUMMARY',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Payment Method'),
                      Text('Tap & Relax, Pay with Bank Transfer'),
                      Divider(color: Colors.black),
                      Text('Payment Details'),
                      Text('Total Items: ${cartItems.length}'),
                      Text('Total Amount : ₦ ${cartProvider.totalAmount.toStringAsFixed(2)}'),
                      SizedBox(height: 20.0),
                      CustomButton(
                        backgroundColor: appColor.withOpacity(0.7),
                        borderColor: appColor,
                        text: 'APPROVED',
                        textColor: whiteColor,
                        function: _handleApproval,
                        boderWidth: 0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


*/