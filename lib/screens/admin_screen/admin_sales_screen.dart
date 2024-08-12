import 'package:billyinventory/models/sales_model.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class AdminSalesScreen extends StatefulWidget {
  @override
  _AdminSalesScreenState createState() => _AdminSalesScreenState();
}

class _AdminSalesScreenState extends State<AdminSalesScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();
  List<QueryDocumentSnapshot> allSales = [];
  List<QueryDocumentSnapshot> filteredSales = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterSales);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterSales);
    _searchController.dispose();
    super.dispose();
  }

  void _filterSales() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredSales = allSales.where((sale) {
        final empName = sale['empName'].toString().toLowerCase();
        return empName.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Sales Details',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by employee name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Sales List
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('sales').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No sales found.'));
                  }

                  // Update the list of all sales whenever new data is received
                  allSales = snapshot.data!.docs;

                  // Re-apply the filter to the updated list of sales
                  filteredSales = allSales.where((sale) {
                    final empName = sale['empName'].toString().toLowerCase();
                    return empName
                        .contains(_searchController.text.toLowerCase());
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredSales.length,
                    itemBuilder: (context, index) {
                      final saleDoc = filteredSales[index];
                      final sale = Sales.fromSnap(saleDoc);

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 4,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16.0),
                          title: Text(
                            'Sale Date: ${DateFormat('yyyy-MM-dd').format(sale.salesDate)}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8.0),
                              Text('Total Items: ${sale.totalItems}'),
                              Text(
                                'Total Price: ₦${sale.totalPrice.toStringAsFixed(2)}',
                              ),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/adminsalesdetailscreen',
                              arguments: sale,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
