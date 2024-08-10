import 'package:billyinventory/models/products_model.dart';
import 'package:billyinventory/screens/admin_screen/admin_widgets/admin_custom_button.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AdminViewProductDetails extends StatefulWidget {
  const AdminViewProductDetails({super.key});

  @override
  State<AdminViewProductDetails> createState() =>
      _AdminViewProductDetailsState();
}

class _AdminViewProductDetailsState extends State<AdminViewProductDetails> {
  @override
  @override
  Widget build(BuildContext context) {
    final Product prodData =
        ModalRoute.of(context)!.settings.arguments as Product;

    String statusText = prodData.quantity < 10 ? 'Low' : 'Active';
    Color statusColor = prodData.quantity < 10 ? Colors.red : Colors.green;

    return Scaffold(
      backgroundColor: adminBackgroundColor,
      appBar: AppBar(
        backgroundColor: adminBackgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Billy Inventory',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: appColor,
              ),
            ),
            SizedBox(
              width: 35,
              height: 35,
              child: SvgPicture.asset(
                'assets/app_icon.svg',
              ),
            ),
          ],
        ),
      ),
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
                            .pushReplacementNamed('/adminstorescreen');
                      },
                      width: 100,
                      height: 45,
                      name: 'Back',
                      widgetName: Icon(Icons.arrow_back),
                    ),
                    Text(
                      'Product Details',
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
                          child: Image(
                            image: NetworkImage(
                              prodData.productImage,
                            ),
                            fit: BoxFit.cover,
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
                        prodData.productName.toString(),
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
                                '₦${prodData.costPrice}',
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
                                '₦${prodData.sellingPrice}',
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
                              Text(
                                statusText,
                                style: TextStyle(color: statusColor),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Product Key'),
                              Text(
                                '',
                                overflow: TextOverflow.ellipsis,
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
                                prodData.category,
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
                                prodData.quantity.toString(),
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
                      Text(prodData.description),
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
