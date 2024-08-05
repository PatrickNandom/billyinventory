

import 'dart:typed_data';

import 'package:billyinventory/common_widgets/my_custom_drawer.dart';
import 'package:billyinventory/common_widgets/my_custom_appbar.dart';
import 'package:billyinventory/common_widgets/my_custom_button.dart';
import 'package:billyinventory/screens/admin_screen/admin_widgets/admin_custom_button.dart';
import 'package:billyinventory/services/firestore_services.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:billyinventory/utils/show_progress_indicator.dart';
import 'package:billyinventory/utils/snachbar.dart';
import 'package:flutter/material.dart';

class ProductPreviewScreen extends StatefulWidget {
  const ProductPreviewScreen({super.key});

  @override
  State<ProductPreviewScreen> createState() => _ProductPreviewScreenState();
}

class _ProductPreviewScreenState extends State<ProductPreviewScreen> {
  Map<String, dynamic>? data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      data = args;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Scaffold(
        backgroundColor: adminBackgroundColor,
        drawer: appDrawer(),
        appBar: myCustomAppbar(() {}),
        body: Center(child: Text('No product data provided')),
      );
    }

    Future<void> addProduct() async {
      try {
        showProgressIndicator(context);

        await FirestoreService().addProduct(
          data!['productKey'],
          data!['productName'],
          data!['productImage'],
          data!['productDescription'],
          data!['productCategory'],
          data!['productCostPrice'],
          data!['productSellingPrice'],
          data!['productQuantity'],
        );
        Navigator.pop(context);
        showSnackBar(context, 'Product details saved successfully');
        Navigator.of(context).pushReplacementNamed('/adminaddproductscreen');
      } catch (e) {
        print('Error picking image: $e');
        Navigator.pop(context);
        showSnackBar(context, 'Custom Error ${e.toString()}');
      }
    }

    return Scaffold(
      backgroundColor: adminBackgroundColor,
      drawer: appDrawer(),
      appBar: myCustomAppbar(() {}),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButtonGlobal(
                      function: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/adminaddproductscreen');
                      },
                      width: 100,
                      height: 45,
                      name: 'Back',
                      widgetName: Icon(Icons.arrow_back),
                    ),
                    Text(
                      'Product preview',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: whiteColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: myLightGrayColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Product Information',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              CustomButton(
                                backgroundColor: Colors.transparent,
                                boderWidth: 2,
                                btnWidth: 60.0,
                                borderColor: Colors.black,
                                text: 'Edit',
                                textColor: Colors.black,
                                function: () {},
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              CustomButton(
                                backgroundColor: myGreenColor,
                                boderWidth: 2,
                                btnWidth: 60.0,
                                borderColor: myGreenColor,
                                text: 'Save',
                                textColor: whiteColor,
                                function: addProduct,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: data!['productImage'] != null
                              ? Image.memory(
                                  data!['productImage'] as Uint8List,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                              : Center(
                                  child: Text("No immage"),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text('Product Name'),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        data!['productName'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Cost Price'),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'N ${data!['productCostPrice']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Selling Price'),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'N ${data!['productSellingPrice']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Status'),
                              SizedBox(
                                height: 5.0,
                              ),
                              CustomButton(
                                backgroundColor: Colors.transparent,
                                boderWidth: 2,
                                btnWidth: 70.0,
                                borderColor: myGreenColor,
                                text: 'Active',
                                textColor: myGreenColor,
                                function: () {},
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Product Key'),
                              Text(
                                data!['productKey'] as String,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Category'),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                data!['productCategory'] as String,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Quantity'),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                data!['productQuantity'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: myLightGrayColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        data!['productDescription'] as String,
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
