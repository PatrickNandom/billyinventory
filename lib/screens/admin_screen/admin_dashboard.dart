import 'package:billyinventory/screens/admin_screen/admin_widgets/admin_custom_button.dart';
import 'package:billyinventory/screens/admin_screen/admin_widgets/admin_grey_container.dart';
import 'package:billyinventory/common_widgets/my_custom_appbar.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

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
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Dashboard',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    CustomButtonGlobal(
                      function: () {},
                      width: 95,
                      height: 45,
                      name: 'Filter',
                      widgetName: Image.asset('assets/brush.png'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                const AdmingreyContainer(
                  topIconPath: 'assets/admin_chart_icon.svg',
                  containerTitle: 'Total Products',
                  rightContainerTile: '3,001',
                  rightContainerIconPath:
                      'assets/right_container_arrow_icon.svg',
                  rigtContainerPercentage: '30%',
                  bottomIconPath: '',
                ),
                const SizedBox(
                  height: 20,
                ),
                const AdmingreyContainer(
                  topIconPath: 'assets/admin_profile_use_icon.svg',
                  containerTitle: 'Total Employees',
                  rightContainerTile: '21',
                  rightContainerIconPath:
                      'assets/right_container_arrow_icon.svg',
                  rigtContainerPercentage: '8%',
                  bottomIconPath: '',
                ),
                const SizedBox(
                  height: 20,
                ),
                const AdmingreyContainer(
                  topIconPath: 'assets/admin_card_tick_icon.svg',
                  containerTitle: 'Total Order Paid',
                  rightContainerTile: 'N3000',
                  rightContainerIconPath:
                      'assets/right_container_arrow_icon.svg',
                  rigtContainerPercentage: '70%',
                  bottomIconPath: '',
                ),
                const SizedBox(
                  height: 20,
                ),
                const AdmingreyContainer(
                  topIconPath: 'assets/addmin_shopping_cart_icon.svg',
                  containerTitle: 'Total Sales',
                  rightContainerTile: 'N20,000',
                  rightContainerIconPath:
                      'assets/right_container_arrow_icon.svg',
                  rigtContainerPercentage: '70%',
                  bottomIconPath: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
