import 'package:billyinventory/models/user_model.dart';
import 'package:billyinventory/screens/admin_screen/admin_dashboard.dart';
import 'package:billyinventory/screens/employee_screen/employee_dashboard.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  final User user;

  const DashboardPage({super.key, required this.user});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {


  @override
  Widget build(BuildContext context) {
    return widget.user.isAdmin
        ? const AdminDashboard()
        : const EmeployeeDashboard();
  }
}
