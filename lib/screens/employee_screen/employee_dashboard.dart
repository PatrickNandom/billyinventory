import 'package:billyinventory/common_widgets/my_custom_search_bar.dart';
import 'package:billyinventory/providers/card_provider.dart';
import 'package:billyinventory/providers/user_provider.dart';
import 'package:billyinventory/screens/employee_screen/employee_profile_screen.dart';
import 'package:billyinventory/screens/employee_screen/emplyee_widgets/employee_custom_drawer.dart';
import 'package:billyinventory/screens/employee_screen/emplyee_widgets/employee_product_card.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmeployeeDashboard extends StatefulWidget {
  const EmeployeeDashboard({super.key});

  @override
  State<EmeployeeDashboard> createState() => _EmeployeeDashboardState();
}

class _EmeployeeDashboardState extends State<EmeployeeDashboard> {
  final searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
     final user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: adminBackgroundColor,
        title: Row(
          children: [
            Spacer(
              flex: 1,
            ),
            Text(
              'Billy Inventory',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: appColor,
              ),
            ),
            Spacer(
              flex: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EmployeeSettingsScreen(),
                  ),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(
                    width: 2,
                    color: appColor,
                  ),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.network(
                     user.profileImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: NavBar(),
      drawerEnableOpenDragGesture: false,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/emplyeecardscreen');
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: 30.0),
          child: Stack(
            children: [
              Icon(
                Icons.shopping_cart,
                size: 45,
                color: appColor,
              ),
              Positioned(
                left: 17,
                top: 2,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      Provider.of<CartProvider>(context)
                          .items
                          .length
                          .toString(),
                      style: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 9),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: CustomSearchBar(
                  controller: searchEditingController,
                  searchContainerWidth: 299.0,
                  searchContainerHeight: 30,
                  searchContainerBorderColor: appColor,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Most Recently',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                width: double.infinity,
                color: myLightGrayColor,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: backgroundColor,
                        color: appColor,
                      ));
                      // return showProgressIndicator(context);
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No products found'));
                    }

                    final products = snapshot.data!.docs;

                    return Container(
                      height: 150,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          // childAspectRatio: 0.7,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(
                            imageUrl: product['productImage'],
                            name: product['productName'],
                            price: product['sellingPrice'],
                            function: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .addItem(
                                product['productId'],
                                product['productName'],
                                product['sellingPrice'],
                                product['productImage'],
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Household Category Products',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                width: double.infinity,
                color: myLightGrayColor,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No products found'));
                    }

                    final products = snapshot.data!.docs;

                    return Container(
                      height: 300,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                          // childAspectRatio: 0.7,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(
                            imageUrl: product['productImage'],
                            name: product['productName'],
                            price: product['sellingPrice'],
                            function: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .addItem(
                                product['productId'],
                                product['productName'],
                                product['sellingPrice'],
                                product['productImage'],
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Other Category Products',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                width: double.infinity,
                color: myLightGrayColor,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No products found'));
                    }

                    final products = snapshot.data!.docs;

                    return Container(
                      height: 300,
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                          // childAspectRatio: 0.7,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(
                            imageUrl: product['productImage'],
                            name: product['productName'],
                            price: product['sellingPrice'],
                            function: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .addItem(
                                product['productId'],
                                product['productName'],
                                product['sellingPrice'],
                                product['productImage'],
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




/*
import 'package:billyinventory/common_widgets/my_custom_search_bar.dart';
import 'package:billyinventory/providers/card_provider.dart';
import 'package:billyinventory/providers/user_provider.dart';
import 'package:billyinventory/screens/employee_screen/employee_profile_screen.dart';
import 'package:billyinventory/screens/employee_screen/emplyee_widgets/employee_custom_drawer.dart';
import 'package:billyinventory/screens/employee_screen/emplyee_widgets/employee_product_card.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmeployeeDashboard extends StatefulWidget {
  const EmeployeeDashboard({super.key});

  @override
  State<EmeployeeDashboard> createState() => _EmeployeeDashboardState();
}

class _EmeployeeDashboardState extends State<EmeployeeDashboard> {
  final searchEditingController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    searchEditingController.addListener(_updateSearchQuery);
  }

  void _updateSearchQuery() {
    setState(() {
      searchQuery = searchEditingController.text.trim();
    });
  }

  @override
  void dispose() {
    searchEditingController.removeListener(_updateSearchQuery);
    searchEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: adminBackgroundColor,
        title: Row(
          children: [
            Spacer(flex: 1),
            Text(
              'Billy Inventory',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: appColor,
              ),
            ),
            Spacer(flex: 1),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EmployeeSettingsScreen(),
                  ),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(
                    width: 2,
                    color: appColor,
                  ),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.network(
                    user.profileImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: NavBar(),
      drawerEnableOpenDragGesture: false,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/emplyeecardscreen');
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: 30.0),
          child: Stack(
            children: [
              Icon(
                Icons.shopping_cart,
                size: 45,
                color: appColor,
              ),
              Positioned(
                left: 17,
                top: 2,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      Provider.of<CartProvider>(context)
                          .items
                          .length
                          .toString(),
                      style: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 9),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Center(
                child: CustomSearchBar(
                  controller: searchEditingController,
                  searchContainerWidth: 299.0,
                  searchContainerHeight: 30,
                  searchContainerBorderColor: appColor,
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Most Recently',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                width: double.infinity,
                color: myLightGrayColor,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .where('productName', isGreaterThanOrEqualTo: searchQuery)
                      .where('productName', isLessThanOrEqualTo: searchQuery + '\uf8ff')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: backgroundColor,
                          color: appColor,
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No products found'));
                    }

                    final products = snapshot.data!.docs;

                    return Container(
                      height: 150,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(
                            imageUrl: product['productImage'],
                            name: product['productName'],
                            price: product['sellingPrice'],
                            function: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .addItem(
                                product['productId'],
                                product['productName'],
                                product['sellingPrice'],
                                product['productImage'],
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Household Category Products',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                width: double.infinity,
                color: myLightGrayColor,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No products found'));
                    }

                    final products = snapshot.data!.docs;

                    return Container(
                      height: 300,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(
                            imageUrl: product['productImage'],
                            name: product['productName'],
                            price: product['sellingPrice'],
                            function: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .addItem(
                                product['productId'],
                                product['productName'],
                                product['sellingPrice'],
                                product['productImage'],
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Other Category Products',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                width: double.infinity,
                color: myLightGrayColor,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No products found'));
                    }

                    final products = snapshot.data!.docs;

                    return Container(
                      height: 300,
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(
                            imageUrl: product['productImage'],
                            name: product['productName'],
                            price: product['sellingPrice'],
                            function: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .addItem(
                                product['productId'],
                                product['productName'],
                                product['sellingPrice'],
                                product['productImage'],
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

*/