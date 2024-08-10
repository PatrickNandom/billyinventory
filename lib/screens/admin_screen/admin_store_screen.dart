import 'package:billyinventory/models/products_model.dart';
import 'package:billyinventory/services/firestore_services.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final _firestoreService = FirestoreService();
  String searchQuery = '';

  // Future<void> _deleteProduct(String productId) async {
  //   await FirebaseFirestore.instance
  //       .collection('products')
  //       .doc(productId)
  //       .delete();
  // }

  void _showActions(BuildContext context, Product product) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(0, 0, 0, 0),
      items: [
        PopupMenuItem(
          value: 'view',
          child: Row(
            children: [
              Icon(Icons.visibility, color: appColor),
              SizedBox(width: 8),
              Text('View'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit, color: appColor),
              SizedBox(width: 8),
              Text('Edit'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete'),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    ).then(
      (value) {
        if (value == 'view') {
          Navigator.of(context)
              .pushNamed('/viewproductdetails', arguments: product);
        } else if (value == 'edit') {
          Navigator.of(context).pushNamed('/editproduct', arguments: product);
        } else if (value == 'delete') {
          _firestoreService.deleteProduct(product.productId);
          // _deleteProduct(product.productId);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: adminBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Store',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: appColor,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline, size: 30),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed('/adminaddproductscreen');
            },
          ),
          SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search, color: appColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: whiteColor,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
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

                  return SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                          bottom: Radius.circular(20),
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
                          0: FlexColumnWidth(120.0),
                          1: FixedColumnWidth(80.0),
                          2: FixedColumnWidth(70.0),
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
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Actions',
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
                          ...filteredDocs.map(
                            (doc) {
                              var product = Product.fromSnap(doc);

                              String statusText =
                                  product.quantity < 10 ? 'Low' : 'Active';
                              Color statusColor = product.quantity < 10
                                  ? Colors.red
                                  : Colors.green;

                              return TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                children: [
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
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 12,
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          statusText,
                                          style: TextStyle(color: statusColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 12),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text('${product.quantity}')),
                                    ),
                                  ),
                                  TableCell(
                                    child: Center(
                                      child: IconButton(
                                        icon: Icon(Icons.more_vert),
                                        onPressed: () =>
                                            _showActions(context, product),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                          TableRow(
                            children: [
                              TableCell(
                                child: SizedBox(height: 20),
                              ),
                              TableCell(
                                child: SizedBox(height: 20),
                              ),
                              TableCell(
                                child: SizedBox(height: 20),
                              ),
                              TableCell(
                                child: SizedBox(height: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
