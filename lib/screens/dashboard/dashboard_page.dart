import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:neopos/navigation/route_paths.dart';

import 'dashboard_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  int selectedIndex = 0;
  final SideMenuController sideMenu = SideMenuController();
  PageController pageController = PageController();
  final List<_NavigationItem> _listItems = [
    _NavigationItem(true, null, null, null),
    _NavigationItem(false, NavItem.page_one, "First Page", Icons.looks_one),
    _NavigationItem(false, NavItem.page_two, "Second Page", Icons.looks_two),
    _NavigationItem(false, NavItem.page_three, "Third Page", Icons.looks_3),
    _NavigationItem(false, NavItem.page_four, "Fourth Page", Icons.looks_4),
    _NavigationItem(false, NavItem.page_five, "Fifth Page", Icons.looks_5),
    _NavigationItem(false, NavItem.page_six, "Sixth Page", Icons.looks_6),
  ];
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
                  Navigator.pushReplacementNamed(context, RoutePaths.login);
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

void _handleItemClick(BuildContext context, NavItem item) {
  BlocProvider.of<DashboardBloc>(context).add(NavigateTo(item));
  Navigator.pop(context);
}
// helper class used to represent navigation list items
class _NavigationItem {
  final bool header;
  final NavItem? item;
  final String? title;
  final IconData? icon;
  _NavigationItem(this.header, this.item, this.title, this.icon);
}

