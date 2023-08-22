import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:neopos/screens/dashboard/side_menu.dart';
import 'package:neopos/screens/login/login_bloc.dart';

import 'package:neopos/screens/products/products_page/read_products_page.dart';
import '../../navigation/route_paths.dart';
import '../../utils/sharedpref/sharedpreference.dart';
import '../order history/order_history_page.dart';
import '../order page/order_table_page/order_read_page.dart';
import '../sales_dashboard/sales_dashboard_page.dart';
import '../table/table_page/table_page.dart';
import '../category/category_page/read_category_page.dart';
import '../users/user_page/read_user_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardPage extends StatefulWidget {
   PageController pageController = PageController();
  var userRole;
   DashboardPage({Key? key, this.userRole}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {


  @override
  void initState() {
    LocalPreference.getUserRole() ?? LocalPreference.setUserRole(LoginBloc.userRole);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> adminPage=[
      const SingleChildScrollView(child: CategoryRead()),
      const SingleChildScrollView(child: ProductsRead()),
      const SingleChildScrollView(child: TableRead()),
      const SingleChildScrollView(child: OrderPageRead()),
      SingleChildScrollView(
          child: SalesDashboardPage(widget.pageController)),
      const SingleChildScrollView(child: OrderHistoryPage()),
      const SingleChildScrollView(child: UserRead()),
    ];
    List<Widget> waiterPage=[
      const SingleChildScrollView(child: OrderPageRead()),
      const SingleChildScrollView(child: OrderHistoryPage()),
    ];

    return WillPopScope( onWillPop: () async {
      return false;
    },
      child: Scaffold(
         appBar: AppBar(
           automaticallyImplyLeading: false,
           title: Text(AppLocalizations.of(context)!.dashboard_title),
           actions: [
             IconButton(
                 onPressed: () async {
                   LocalPreference.clearAllPreference();
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
                   child:
                   SideMenuWidget(LocalPreference.getUserRole(),widget.pageController)
                 ),
                 Expanded(
                   flex: 7,
                   child: PageView(
                     physics: const NeverScrollableScrollPhysics(),
                     controller: widget.pageController,
      children: LocalPreference.getUserRole() =='Admin' ? adminPage : waiterPage
                   ),
                 )
               ],
             ),
           )
         ]))),
    );
  }
}
