import 'package:billyinventory/common_widgets/my_custom_appbar.dart';
import 'package:flutter/material.dart';

class AdminStorScreen extends StatefulWidget {
  const AdminStorScreen({super.key});

  @override
  State<AdminStorScreen> createState() => _AdminStorScreenState();
}

class _AdminStorScreenState extends State<AdminStorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppbar(() {}),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Table(
              textDirection: TextDirection.ltr,
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(
                color: Colors.black,
                width: 2.0,
                borderRadius: BorderRadius.circular(6.0),
              ),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.brown),
                  children: [
                    TableCell(
                      child: Text(
                        'S/N',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        'Product Name',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        'Status',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        'Product Key',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    TableCell(
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        'Bread',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        'Active',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        '........',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    TableCell(
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        'Bread',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        'Active',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        '........',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
