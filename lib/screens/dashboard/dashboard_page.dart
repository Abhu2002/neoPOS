import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:neopos/screens/products/products_page/read_products_page.dart';
import '../../navigation/route_paths.dart';
import 'package:neopos/utils/app_colors.dart';
import '../table/table_page/table_page.dart';
import '../category/category_page/read_category_page.dart';
import '../users/user_page/read_user_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
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

  @override
  Widget build(BuildContext context) {
    List<SideMenuItem> items = [
      SideMenuItem(
        icon: const Icon(Icons.category),
        title: AppLocalizations.of(context)!.category_title,
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
      ),
      SideMenuItem(
        icon: const Icon(Icons.restaurant_menu),
        title: AppLocalizations.of(context)!.products_title,
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
      ),
      SideMenuItem(
        icon: const Icon(Icons.table_chart),
        title: AppLocalizations.of(context)!.tables_title,
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
      ),
      SideMenuItem(
        icon: const Icon(Icons.dashboard),
        title: AppLocalizations.of(context)!.dashboard_title,
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
      ),
      SideMenuItem(
        icon: const Icon(Icons.shopping_cart),
        title: AppLocalizations.of(context)!.order_history_title,
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
      ),
      SideMenuItem(
        icon: const Icon(Icons.person),
        title: AppLocalizations.of(context)!.users_title,
        onTap: (index, sideMenuController) {
          sideMenuController.changePage(index);
        },
      ),
    ];
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
            child: CustomScrollView(slivers: [
          SliverFillRemaining(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: SideMenu(
                      items: items,
                      controller: sideMenu,
                      style: SideMenuStyle(
                          openSideMenuWidth: 180,
                          displayMode: SideMenuDisplayMode.auto,
                          backgroundColor: Colors.grey.shade50,
                          selectedColor: AppColors.primarySwatch.shade50,
                          selectedIconColor: AppColors.primarySwatch.shade400,
                          selectedTitleTextStyle: TextStyle(
                              color: AppColors.primarySwatch.shade400))),
                ),
                Expanded(
                  flex: 7,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: const [
                      SingleChildScrollView(child: CategoryRead()),

                      ProductsRead(),

                      SingleChildScrollView(child: TableRead()),

                      ///TODO DashBoard and History page pending
                      Center(
                        child: Text('DashBoard Page'),
                      ),
                      Center(
                        child: Text('Order History'),
                      ),
                      SingleChildScrollView(child: UserRead()),
                    ],
                  ),
                )
              ],
            ),
          )
        ])));
  }
}
