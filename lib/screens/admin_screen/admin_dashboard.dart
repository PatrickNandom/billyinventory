import 'package:billyinventory/screens/admin_screen/admin_widgets/admin_custorm_drawer.dart';
import 'package:billyinventory/screens/admin_screen/admin_widgets/admin_grey_container.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: adminBackgroundColor,
      appBar: AppBar(
        backgroundColor: adminBackgroundColor,
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
            GestureDetector(
              onTap: () {},
              child: Stack(
                children: [
                  Icon(
                    Icons.notifications,
                    color: Colors.red,
                    size: 33,
                  ),
                  Positioned(
                    left: 10,
                    top: 7,
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          '0',
                          style: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
      drawer: AdminNavBar(),
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
                      'A d m i n   D a s h b o a r d',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ), 
                    ),
                    Text(''),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                const AdmingreyContainer(
                  topIconPath: 'assets/admin_chart_icon.svg',
                  containerTitle: 'Total Products',
                  rightContainerTile: '189',
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
                  topIconPath: 'assets/addmin_shopping_cart_icon.svg',
                  containerTitle: 'Total Sales',
                  rightContainerTile: '₦20,000',
                  rightContainerIconPath:
                      'assets/right_container_arrow_icon.svg',
                  rigtContainerPercentage: '70%',
                  bottomIconPath: '',
                ),
                const SizedBox(
                  height: 20,
                ),
                const AdmingreyContainer(
                  topIconPath: 'assets/admin_card_tick_icon.svg',
                  containerTitle: 'Top-Selling Products',
                  rightContainerTile: '45',
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
