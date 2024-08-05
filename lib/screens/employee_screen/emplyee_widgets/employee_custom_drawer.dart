import 'package:billyinventory/providers/user_provider.dart';
import 'package:billyinventory/screens/admin_screen/admin_store_screen.dart';
import 'package:billyinventory/screens/employee_screen/employee_dashboard.dart';
import 'package:billyinventory/screens/employee_screen/employee_profile_screen.dart';
import 'package:billyinventory/services/auth_service.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;

    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      backgroundColor: adminBackgroundColor,
      child: ListView(
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
                  builder: (context) => const EmeployeeDashboard(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EmployeeSettingsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.show_chart),
            title: Text('View Sales'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StorePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await _authService.signOutUser();
              // if (context.mounted) {
              Navigator.of(context).pushReplacementNamed('/');
              // }
            },
          ),
        ],
      ),
    );
  }
}
