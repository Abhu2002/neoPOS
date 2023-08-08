import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/products/products_page/read_products_page.dart';
import 'package:neopos/utils/common_text.dart';
import '../../navigation/route_paths.dart';
import 'package:neopos/utils/app_colors.dart';
import '../order page/order_page/order_read_page/order_read_page.dart';
import '../products/products_page/read_products_bloc.dart';
import '../table/table_page/table_page.dart';
import '../category/category_page/read_category_page.dart';
import '../users/user_page/read_user_page.dart';

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

  List<SideMenuItem> items = [
    SideMenuItem(
      icon: const Icon(Icons.category),
      title: 'Category',
      onTap: (index, sideMenuController) {
        sideMenuController.changePage(index);
      },
    ),
    SideMenuItem(
      icon: const Icon(Icons.restaurant_menu),
      title: 'Products',
      onTap: (index, sideMenuController) {
        sideMenuController.changePage(index);
      },
    ),
    SideMenuItem(
      icon: const Icon(Icons.table_chart),
      title: 'Tables',
      onTap: (index, sideMenuController) {
        sideMenuController.changePage(index);
      },
    ),
    SideMenuItem(
      icon: const Icon(Icons.dashboard),
      title: 'Order Page',
      onTap: (index, sideMenuController) {
        sideMenuController.changePage(index);
      },
    ),
    SideMenuItem(
      icon: const Icon(Icons.dashboard),
      title: 'Dashboard',
      onTap: (index, sideMenuController) {
        sideMenuController.changePage(index);
      },
    ),
    SideMenuItem(
      icon: const Icon(Icons.shopping_cart),
      title: 'Order History',
      onTap: (index, sideMenuController) {
        sideMenuController.changePage(index);
      },
    ),
    SideMenuItem(
      icon: const Icon(Icons.person),
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
            child: CustomScrollView(slivers: [
          SliverFillRemaining(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocBuilder<ReadProductsBloc, ReadProductsState>(
                    builder: (context, state) {
                  if (state is ButtonState) {
                    return SideMenu(
                        items: items,
                        controller: sideMenu,
                        style: SideMenuStyle(
                            openSideMenuWidth: 180,
                            displayMode: state.mod,
                            backgroundColor: Colors.grey.shade50,
                            selectedColor: AppColors.primarySwatch.shade50,
                            selectedIconColor: AppColors.primarySwatch.shade400,
                            selectedTitleTextStyle: TextStyle(
                                color: AppColors.primarySwatch.shade400)));
                  }
                  return SideMenu(
                      items: items,
                      controller: sideMenu,
                      style: SideMenuStyle(
                          openSideMenuWidth: 180,
                          displayMode: ConstantVar.mode,
                          backgroundColor: Colors.grey.shade50,
                          selectedColor: AppColors.primarySwatch.shade50,
                          selectedIconColor: AppColors.primarySwatch.shade400,
                          selectedTitleTextStyle: TextStyle(
                              color: AppColors.primarySwatch.shade400)));
                }),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: const [
                      SingleChildScrollView(child: CategoryRead()),

                      ProductsRead(),

                      SingleChildScrollView(child: TableRead()),

                      SingleChildScrollView(child: OrderPageRead()),

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
