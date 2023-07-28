import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

import '../login/login_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          actions: [
            IconButton(
                onPressed: () async {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const LoginPage()));
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SideNavigationBar(

                      selectedIndex: selectedIndex,
                      items: const [
                        SideNavigationBarItem(
                          icon: Icons.category,
                          label: 'Category',
                        ),
                        SideNavigationBarItem(
                          icon: Icons.restaurant_menu,
                          label: 'Products',
                        ),
                        SideNavigationBarItem(
                          icon: Icons.table_chart,
                          label: 'Tables',
                        ),
                        SideNavigationBarItem(
                          icon: Icons.dashboard,
                          label: 'Dashboard',
                        ),
                        SideNavigationBarItem(
                          icon: Icons.shopping_cart,
                          label: 'Order History',
                        ),
                        SideNavigationBarItem(
                          icon: Icons.person,
                          label: 'Users',
                        ),
                      ],
                      onTap: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
