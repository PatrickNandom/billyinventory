

import 'package:billyinventory/models/sales_model.dart';
import 'package:billyinventory/screens/admin_screen/admin_widgets/admin_sales_row.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class AdminSalesDetailScreen extends StatelessWidget {
  const AdminSalesDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Sales sale = ModalRoute.of(context)!.settings.arguments as Sales;
    return Scaffold(
      backgroundColor: adminBackgroundColor,
      appBar: AppBar(
        backgroundColor: appColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Sales Information',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: whiteColor,
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
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(
                color: appColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdminSalesRow(
                  leftItem: 'Employee Name',
                  rightItem: sale.empName,
                ),
                SizedBox(
                  height: 10,
                ),
                AdminSalesRow(
                  leftItem: 'Sale Date',
                  rightItem:
                      '${DateFormat('yyyy-MM-dd').format(sale.salesDate)}',
                ),
                SizedBox(
                  height: 10,
                ),
                AdminSalesRow(
                  leftItem: 'Total Item Sold',
                  rightItem: sale.totalItems.toString(),
                ),
                SizedBox(
                  height: 10,
                ),
                AdminSalesRow(
                  leftItem: 'Quantity Sold',
                  rightItem: sale.quantitySold,
                ),
                SizedBox(
                  height: 10,
                ),
                AdminSalesRow(
                  leftItem: 'Total Price',
                  rightItem: '₦ ${sale.totalPrice}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
