import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

import 'package:neopos/screens/products/products_page/read_products_page.dart';
import '../../navigation/route_paths.dart';
import 'package:neopos/utils/app_colors.dart';
import '../order history/order_history_page.dart';
import '../order page/order_table_page/order_read_page.dart';
import '../sales_dashboard/sales_dashboard_page.dart';
import '../table/table_page/table_page.dart';
import '../category/category_page/read_category_page.dart';
import '../users/user_page/read_user_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardPage extends StatefulWidget {
  var userRole;
  static SideMenuController sideMenu = SideMenuController();
  static PageController pageController = PageController();
   DashboardPage({Key? key,this.userRole}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {


  @override
  void initState() {
    // Connect SideMenuController and PageController together
    DashboardPage.sideMenu.addListener((index) {
      DashboardPage.pageController.jumpToPage(index);
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
        title: AppLocalizations.of(context)!.order_page,
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
    List<SideMenuItem> waiterItems = [
      SideMenuItem(
        icon: const Icon(Icons.dashboard),
        title: AppLocalizations.of(context)!.order_page,
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
    ];

    List<Widget> adminPage=[
      const SingleChildScrollView(child: CategoryRead()),
      const SingleChildScrollView(child: ProductsRead()),
      const SingleChildScrollView(child: TableRead()),
      const SingleChildScrollView(child: OrderPageRead()),
      const SingleChildScrollView(child: SalesDashboardPage()),
      const SingleChildScrollView(child: OrderHistoryPage()),
      const SingleChildScrollView(child: UserRead()),
    ];
    List<Widget> waiterPage=[
      const SingleChildScrollView(child: OrderPageRead()),
      const SingleChildScrollView(child: OrderHistoryPage()),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.dashboard_title),
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
                      items: widget.userRole=='Admin' ? items : waiterItems,
                      controller: DashboardPage.sideMenu,
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
                    controller: DashboardPage.pageController,
                    children: widget.userRole=='Admin' ? adminPage : waiterPage
                  ),
                )
              ],
            ),
          )
        ])));
  }
}
