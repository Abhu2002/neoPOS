import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import '../../navigation/route_paths.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  int selectedIndex = 0;
  final SideMenuController sideMenu = SideMenuController();
  PageController pageController = PageController();
  @override
  void initState() {
    // Connect SideMenuController and PageController together
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }
  List<SideMenuItem> items = [
  SideMenuItem(
        icon: Icon(Icons.category),
        title: 'Category',
    onTap: (index, sideMenuController) {
      sideMenuController.changePage(index);
    },
      ),
      SideMenuItem(
        icon: Icon(Icons.restaurant_menu),
        title: 'Products',onTap: (index, sideMenuController) {
        sideMenuController.changePage(index);

      },
      ),
      SideMenuItem(
        icon: Icon(Icons.table_chart),
        title: 'Tables',
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
      ),
      SideMenuItem(
        icon: Icon(Icons.dashboard),
        title: 'Dashboard',
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
      ),
      SideMenuItem(
        icon: Icon(Icons.shopping_cart),
        title: 'Order History',
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },

      ),
      SideMenuItem(
        icon: Icon(Icons.person),
        title: 'Users',
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
      ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          actions: [
            IconButton(
                onPressed: () async {
                  Navigator.pushReplacementNamed(context,RoutePaths.login) ;
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
                    SideMenu(items: items, controller: sideMenu),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        children: [
                          Container(
                            child: Center(
                              child: Text('Dashboard'),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text('Settings'),
                            ),
                          ),
                  ],
                ),
              )
            ],
           ),
        )])));
  }
}


