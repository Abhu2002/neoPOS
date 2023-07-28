import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:neopos/screens/login/login_page.dart';
import 'package:neopos/utils/app_colors.dart';


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
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage(),)) ;
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
                    SideMenu(items: items, controller: sideMenu,style: SideMenuStyle(backgroundColor: Colors.grey.shade50,selectedColor: AppColors.primarySwatch.shade50,selectedIconColor: AppColors.primarySwatch.shade400,selectedTitleTextStyle: TextStyle(color: AppColors.primarySwatch.shade400))),
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


