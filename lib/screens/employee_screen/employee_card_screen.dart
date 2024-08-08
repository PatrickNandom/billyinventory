import 'package:billyinventory/common_widgets/my_custom_button.dart';
import 'package:billyinventory/models/products_model.dart';
import 'package:billyinventory/models/sales_model.dart';
import 'package:billyinventory/providers/card_provider.dart';
import 'package:billyinventory/screens/admin_screen/admin_widgets/admin_custom_button.dart';
import 'package:billyinventory/screens/employee_screen/emplyee_widgets/custom_employee_card_template.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:billyinventory/utils/show_progress_indicator.dart';
import 'package:billyinventory/utils/snachbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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

  // Function to handle the approval and update sales records
  Future<void> _createSales() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final cartItems = cartProvider.items.values.toList();
    if (cartItems.isEmpty) {
      showSnackBar(context, 'No items in cart');
      return;
    }
    final user = _auth.currentUser;
    if (user == null) return;
    showProgressIndicator(context);

    final empId = user.uid;
    final empName = user.displayName ?? 'Unknown';

    try {
      for (final item in cartItems) {
        // Update product quantity
        final productRef =
            _firestore.collection('products').doc(item.productID);
        final productSnap = await productRef.get();
        final product = Product.fromSnap(productSnap);
        final newQuantity = product.quantity - item.quantity;
        if (newQuantity < 0) {
          throw Exception(
              'Insufficient quantity for product ${item.productName}');
        }
        await productRef.update({'quantity': newQuantity});
      }
      // geting the total quantity
      int totlalQuantity = 0;
      cartItems.forEach(
        (item) {
          totlalQuantity += item.quantity;
        },
      );

      print('Total qty$totlalQuantity');
      final salesId = Uuid().v4();
      final sale = Sales(
        saleId: salesId,
        totalItems: cartProvider.items.length,
        quantitySold: totlalQuantity.toString(),
        totalPrice: cartProvider.totalAmount,
        empId: empId,
        empName: empName,
        salesDate: DateTime.now(),
      );

      await _firestore.collection('sales').doc(salesId).set(sale.toJson());
      showSnackBar(context, 'New sales record created sucessfully');
      Navigator.pop(context);
      cartProvider.clearCart();
    } catch (e) {
      showSnackBar(context, 'Error processing sale: $e');
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
                      Text(
                        getCurrentFormattedDate(),
                      ),
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
                      Text(
                          'Total Amount: ₦${cartProvider.totalAmount.toStringAsFixed(2)}'),
                      SizedBox(height: 20.0),
                      CustomButton(
                        backgroundColor: appColor.withOpacity(0.7),
                        borderColor: appColor,
                        text: 'APPROVED',
                        textColor: whiteColor,
                        function: _createSales,
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
