import 'package:billyinventory/models/user_model.dart' as model;
import 'package:billyinventory/screens/admin_screen/admin_dashboard.dart';
import 'package:billyinventory/screens/admin_screen/admin_profile_screen.dart';
import 'package:billyinventory/screens/admin_screen/admin_sales_screen.dart';
import 'package:billyinventory/screens/admin_screen/admin_store_screen.dart';
import 'package:billyinventory/services/auth_service.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:billyinventory/utils/snachbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminNavBar extends StatelessWidget {
  AdminNavBar({super.key});
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return Center(child: Text('No user logged in'));
    }
    final userId = currentUser.uid;

    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      backgroundColor: adminBackgroundColor,
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text('User not found'),
            );
          }

          // Use the User model to handle data
          model.User user = model.User.fromSnap(snapshot.data!);
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: appColor),
                accountName: Text(
                  user.name,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                accountEmail: Text(user.email),
                currentAccountPicture: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: whiteColor,
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
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AdminDashboard(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.inventory),
                title: Text('Products'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StorePage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.show_chart),
                title: Text('Sales'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AdminSalesScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: Text('Empleyees'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Profile'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AdminProfileScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () async {
                  try {
                    await _authService.signOutUser();
                    if (context.mounted) {
                      Navigator.of(context).pushReplacementNamed('/');
                    }
                  } catch (error) {
                    print('logout error: ${error}');
                    showSnackBar(context, 'Failed to sign out: $error');
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
