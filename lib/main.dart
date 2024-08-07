import 'package:billyinventory/firebase_options.dart';
import 'package:billyinventory/providers/card_provider.dart';
import 'package:billyinventory/providers/user_provider.dart';
import 'package:billyinventory/screens/admin_screen/admin_add_product_screen.dart';
import 'package:billyinventory/screens/admin_screen/admin_product_preview_screen.dart';
import 'package:billyinventory/screens/admin_screen/admin_product_screen.dart';
import 'package:billyinventory/screens/employee_screen/employee_card_screen.dart';
import 'package:billyinventory/screens/employee_screen/employee_dashboard.dart';
import 'package:billyinventory/screens/login_screen.dart';
import 'package:billyinventory/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => Login(),
          '/signup': (context) => SignUp(),
          '/emplyeecardscreen': (context) => EmployeeCardScreen(),
          '/emplyeedashboard': (context) => EmployeeDashboard(),
          '/productpreview': (context) => ProductPreviewScreen(),
          '/adminaddproductscreen': (context) => AddProductScreen(),
          '/adminproductscreen': (context) => ProductScreen(),
        },
      ),
    );
  }
}
