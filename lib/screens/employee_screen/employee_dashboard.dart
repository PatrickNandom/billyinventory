import 'package:billyinventory/common_widgets/my_custom_drawer.dart';
import 'package:billyinventory/common_widgets/my_custom_search_bar.dart';
import 'package:billyinventory/common_widgets/my_custom_appbar.dart';
import 'package:billyinventory/screens/login_screen.dart';
import 'package:billyinventory/utils/colors.dart';
import 'package:flutter/material.dart';

class EmeployeeDashboard extends StatefulWidget {
  const EmeployeeDashboard({super.key});

  @override
  State<EmeployeeDashboard> createState() => _EmeployeeDashboardState();
}

class _EmeployeeDashboardState extends State<EmeployeeDashboard> {
  final searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget displayDrawer() {
      return appDrawer();
    }

    return Scaffold(
      appBar: myCustomAppbar(displayDrawer),
      drawer: appDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: CustomSearchBar(
                    controller: searchEditingController,
                    searchContainerWidth: 299.0,
                    searchContainerHeight: 30,
                    searchContainerBorderColor: appColor,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text('Welcome to employee Dashoard'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                  child: const Text('back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
