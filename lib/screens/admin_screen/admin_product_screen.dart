import 'package:billyinventory/screens/admin_screen/admin_add_product_screen.dart';
import 'package:billyinventory/screens/admin_screen/admin_widgets/admin_blue_container.dart';
import 'package:billyinventory/screens/admin_screen/admin_widgets/admin_custom_button.dart';
import 'package:billyinventory/common_widgets/my_custom_appbar.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    void displayDrawer() {}

    return Scaffold(
      backgroundColor: adminBackgroundColor,
      appBar: myCustomAppbar(displayDrawer),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Products',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    CustomButtonGlobal(
                      function: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddProductScreen(),
                          ),
                        );
                      },
                      name: 'Add Products',
                      width: 174,
                      height: 45,
                      widgetName: const Icon(
                        Icons.add,
                        color: whiteColor,
                        size: 23,
                        shadows: [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                MyBlueContainer(
                  containerTitle: 'Total products',
                  containerValue: '3,001',
                  containerPercentage: '+ 4.8% Since last week',
                  btnBgColor: appColor.withOpacity(0.8),
                  btnBorderColor: whiteColor,
                  function: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                MyBlueContainer(
                  containerTitle: 'New Products',
                  containerValue: '1,038',
                  containerPercentage: '+ 2.8% Since last week',
                  btnBgColor: backgroundColor.withOpacity(0.4),
                  btnBorderColor: backgroundColor.withOpacity(0.4),
                  function: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                MyBlueContainer(
                  containerTitle: 'Paid Products',
                  containerValue: '1,098',
                  containerPercentage: '+ 5.0% Since last week',
                  btnBgColor: backgroundColor.withOpacity(0.4),
                  btnBorderColor: backgroundColor.withOpacity(0.4),
                  function: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                MyBlueContainer(
                  containerTitle: 'Old Stock',
                  containerValue: '502',
                  containerPercentage: '+ 8.9% Since last week',
                  btnBgColor: backgroundColor.withOpacity(0.4),
                  btnBorderColor: backgroundColor.withOpacity(0.4),
                  function: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
