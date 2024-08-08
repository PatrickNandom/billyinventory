import 'package:billyinventory/models/sales_model.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class SalesDetailsPage extends StatefulWidget {
  @override
  _SalesDetailsPageState createState() => _SalesDetailsPageState();
}

class _SalesDetailsPageState extends State<SalesDetailsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();
  List<Sales> allSales = [];
  List<Sales> filteredSales = [];

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
        final formattedDate = DateFormat('yyyy-MM-dd').format(sale.salesDate);
        return formattedDate.contains(query);
      }).toList();
    });
  }

  Stream<List<Sales>> _salesStream() {
    final user = _auth.currentUser;
    if (user == null) return Stream.empty();

    Query query =
        _firestore.collection('sales').where('empId', isEqualTo: user.uid);

    return query.snapshots().map((snapshot) {
      final sales = snapshot.docs.map((doc) => Sales.fromSnap(doc)).toList();
      allSales = sales;
      filteredSales = sales; 
      return sales;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sales Details',
          style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: appColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by Date (yyyy-mm-dd)',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Sales List
            Expanded(
              child: StreamBuilder<List<Sales>>(
                stream: _salesStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No sales found.'));
                  }
                  final sales = filteredSales; // Use filteredSales

                  return ListView.builder(
                    itemCount: sales.length,
                    itemBuilder: (context, index) {
                      final sale = sales[index];
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
                                  'Total Price: ₦${sale.totalPrice.toStringAsFixed(2)}'),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            // Handle card tap (e.g., show more details)
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
