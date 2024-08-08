import 'package:billyinventory/models/products_model.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: adminBackgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Store',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: 200,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search product',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: whiteColor,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: appColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No products found'));
          }

          var filteredDocs = snapshot.data!.docs.where(
            (doc) {
              var data = doc.data() as Map<String, dynamic>;
              var productName = data['productName'] ?? '';
              return productName.toLowerCase().contains(searchQuery);
            },
          ).toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)
                      // top: Radius.circular(20),
                      // bottom: Radius.circular(20),
                      ),
                  border: Border.all(
                    color: const Color.fromARGB(255, 15, 13, 13),
                    width: 1,
                  ),
                ),
                child: Table(
                  border: TableBorder(
                    horizontalInside: BorderSide(
                      width: 1,
                      color: const Color.fromARGB(255, 15, 13, 13),
                    ),
                    verticalInside: BorderSide(
                      width: 1,
                      color: const Color.fromARGB(255, 15, 13, 13),
                    ),
                  ),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(60.0),
                    1: FlexColumnWidth(),
                    2: FixedColumnWidth(120.0),
                    3: FixedColumnWidth(70.0),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: appColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 12.0,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '#',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Product Name',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              // horizontal: 8.0,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Status',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              // horizontal: 8.0,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'QTY',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...filteredDocs.asMap().entries.map((entry) {
                      var index = entry.key;
                      var doc = entry.value;
                      var product = Product.fromSnap(doc);

                      String statusText =
                          product.quantity < 10 ? 'Low' : 'Active';
                      Color statusColor =
                          product.quantity < 10 ? Colors.red : Colors.green;

                      return TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border(
                            bottom: BorderSide(color: Colors.grey),
                          ),
                        ),
                        children: [
                          TableCell(
                            child: Center(
                              child: Text('${index + 1}'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 8.0,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  product.productName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text(
                                statusText,
                                style: TextStyle(color: statusColor),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text('${product.quantity}'),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
