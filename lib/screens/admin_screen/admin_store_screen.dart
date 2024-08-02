// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class GridTableScreen extends StatefulWidget {
//   @override
//   _GridTableScreenState createState() => _GridTableScreenState();
// }

// class _GridTableScreenState extends State<GridTableScreen> {
//   late Future<List<Map<String, dynamic>>> _dataFuture;

//   @override
//   void initState() {
//     super.initState();
//     _dataFuture = fetchData();
//   }

//   Future<List<Map<String, dynamic>>> fetchData() async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('items').get();
//     return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Grid Table Example'),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _dataFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No Data Available'));
//           }

//           List<Map<String, dynamic>> data = snapshot.data!;

//           return SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: SingleChildScrollView(
//               child: Table(
//                 border: TableBorder.all(color: Colors.black),
//                 children: [
//                   // Table header
//                   TableRow(
//                     decoration: BoxDecoration(color: Colors.blueGrey),
//                     children: [
//                       _buildTableCell('Column 1', isHeader: true),
//                       _buildTableCell('Column 2', isHeader: true),
//                       _buildTableCell('Column 3', isHeader: true),
//                     ],
//                   ),
//                   // Table data
//                   for (var item in data)
//                     TableRow(
//                       children: [
//                         _buildTableCell(item['field1'].toString()),
//                         _buildTableCell(item['field2'].toString()),
//                         _buildTableCell(item['field3'].toString()),
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTableCell(String text, {bool isHeader = false}) {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black),
//         color: isHeader ? Colors.blueGrey : Colors.white,
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: isHeader ? Colors.white : Colors.black,
//           fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
//         ),
//       ),
//     );
//   }
// }

////////////////////////////////////////
//  NEW DATA TABLE
/*

// main.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore DataTable',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductTableScreen(),
    );
  }
}

class ProductTableScreen extends StatelessWidget {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product DataTable'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: productsCollection.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                headingRowColor: MaterialStateProperty.all<Color>(Colors.gold),
                border: TableBorder.all(),
                columnSpacing: 16.0,
                headingRowHeight: 50.0,
                dataRowHeight: 60.0,
                columns: const [
                  DataColumn(
                    label: Center(child: Text('S/N')),
                  ),
                  DataColumn(
                    label: Center(child: Text('Product Name')),
                  ),
                  DataColumn(
                    label: Center(child: Text('Price')),
                  ),
                  DataColumn(
                    label: Center(child: Text('Status')),
                  ),
                  DataColumn(
                    label: Center(child: Text('Qty')),
                  ),
                ],
                rows: documents
                    .asMap()
                    .entries
                    .map((entry) {
                      final index = entry.key;
                      final product = entry.value.data() as Map<String, dynamic>;

                      return DataRow(
                        cells: [
                          DataCell(Center(child: Text('${index + 1}'))),
                          DataCell(Center(child: Text(product['name'] ?? ''))),
                          DataCell(Center(child: Text(product['price'].toString()))),
                          DataCell(Center(child: Text(product['status'] ?? ''))),
                          DataCell(Center(child: Text(product['quantity'].toString()))),
                        ],
                      );
                    })
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}


*/