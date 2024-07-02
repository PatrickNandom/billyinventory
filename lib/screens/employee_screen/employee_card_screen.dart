import 'package:billyinventory/common_widgets/my_custom_button.dart';
import 'package:billyinventory/screens/admin_screen/admin_widgets/admin_custom_button.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';

class EmployeeCardScreen extends StatefulWidget {
  const EmployeeCardScreen({super.key});

  @override
  State<EmployeeCardScreen> createState() => _EmployeeCardScreenState();
}

class _EmployeeCardScreenState extends State<EmployeeCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
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
                    SizedBox(
                      width: 45.0,
                    ),
                    Text(
                      'Purchase Details',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: Colors.grey[800]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'ITEMS IN YOUR CARD',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
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
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('Today Tuesday 25 July'),
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 119,
                            height: 66,
                            color: whiteColor,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Fresh whole milk'),
                              Text('QTY:1'),
                              Text('price: ₦ 1000'),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 119,
                            height: 66,
                            color: whiteColor,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Fresh whole milk'),
                              Text('QTY:1'),
                              Text('price: ₦ 1000'),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 119,
                            height: 66,
                            color: whiteColor,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Fresh whole milk'),
                              Text('QTY:1'),
                              Text('price: ₦ 1000'),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'PAYMENT SUMMARY',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
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
                      Divider(
                        color: Colors.black,
                      ),
                      Text('Payment Details'),
                      Text('Total Items: 3'),
                      Text('Total Amount : ₦ 545.00'),
                      SizedBox(
                        height: 20.0,
                      ),
                      CustomButton(
                        backgroundColor: appColor.withOpacity(0.7),
                        borderColor: appColor,
                        text: 'APPROVED',
                        textColor: whiteColor,
                        function: () {},
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
