// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   String searchQuery = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product List'),
//       ),
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 // Search Bar
//                 TextField(
//                   onChanged: (value) {
//                     setState(() {
//                       searchQuery = value;
//                     });
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Search',
//                     prefixIcon: Icon(Icons.search),
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 16),

//                 // Recently Added Products
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 8.0),
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Recently Added',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold)),
//                       SizedBox(height: 8),
//                       StreamBuilder<QuerySnapshot>(
//                         stream: FirebaseFirestore.instance
//                             .collection('products')
//                             .orderBy('addedDate', descending: true)
//                             .limit(10) // Limit to 10 most recent
//                             .snapshots(),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return Center(child: CircularProgressIndicator());
//                           }
//                           if (snapshot.hasError) {
//                             return Center(
//                                 child: Text('Error: ${snapshot.error}'));
//                           }
//                           if (!snapshot.hasData ||
//                               snapshot.data!.docs.isEmpty) {
//                             return Center(child: Text('No products found'));
//                           }

//                           final products = snapshot.data!.docs;

//                           return Container(
//                             height: 200,
//                             child: GridView.builder(
//                               scrollDirection: Axis.horizontal,
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 1,
//                                 crossAxisSpacing: 8.0,
//                                 mainAxisSpacing: 8.0,
//                                 childAspectRatio: 0.7,
//                               ),
//                               itemCount: products.length,
//                               itemBuilder: (context, index) {
//                                 final product = products[index];
//                                 return ProductCard(
//                                   imageUrl: product['imageUrl'],
//                                   name: product['name'],
//                                   price: product['price'],
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Other Section
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 8.0),
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Others',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold)),
//                       SizedBox(height: 8),
//                       StreamBuilder<QuerySnapshot>(
//                         stream: FirebaseFirestore.instance
//                             .collection('products')
//                             .where('category',
//                                 isEqualTo:
//                                     'others') // Change 'others' to your category
//                             .snapshots(),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return Center(child: CircularProgressIndicator());
//                           }
//                           if (snapshot.hasError) {
//                             return Center(
//                                 child: Text('Error: ${snapshot.error}'));
//                           }
//                           if (!snapshot.hasData ||
//                               snapshot.data!.docs.isEmpty) {
//                             return Center(child: Text('No products found'));
//                           }

//                           final products = snapshot.data!.docs;

//                           return Container(
//                             height: 400,
//                             child: GridView.builder(
//                               scrollDirection: Axis.horizontal,
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 8.0,
//                                 mainAxisSpacing: 8.0,
//                                 childAspectRatio: 0.7,
//                               ),
//                               itemCount: products.length,
//                               itemBuilder: (context, index) {
//                                 final product = products[index];
//                                 return ProductCard(
//                                   imageUrl: product['imageUrl'],
//                                   name: product['name'],
//                                   price: product['price'],
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Household Category Products
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 8.0),
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Household',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold)),
//                       SizedBox(height: 8),
//                       StreamBuilder<QuerySnapshot>(
//                         stream: FirebaseFirestore.instance
//                             .collection('products')
//                             .where('category', isEqualTo: 'household')
//                             .snapshots(),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return Center(child: CircularProgressIndicator());
//                           }
//                           if (snapshot.hasError) {
//                             return Center(
//                                 child: Text('Error: ${snapshot.error}'));
//                           }
//                           if (!snapshot.hasData ||
//                               snapshot.data!.docs.isEmpty) {
//                             return Center(child: Text('No products found'));
//                           }

//                           final products = snapshot.data!.docs;

//                           return GridView.builder(
//                             shrinkWrap: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3,
//                               crossAxisSpacing: 8.0,
//                               mainAxisSpacing: 8.0,
//                               childAspectRatio: 0.7,
//                             ),
//                             itemCount: products.length,
//                             itemBuilder: (context, index) {
//                               final product = products[index];
//                               return ProductCard(
//                                 imageUrl: product['imageUrl'],
//                                 name: product['name'],
//                                 price: product['price'],
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
