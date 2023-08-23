import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

import 'Localization bloc/localization_bloc.dart';

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
    LocalPreference.getUserRole() ??
        LocalPreference.setUserRole(LoginBloc.userRole);
    super.initState();
  }

  bool isSwitched = (LocalPreference.getLang() == "en") ? false : true;
  @override
  Widget build(BuildContext context) {
    List<Widget> adminPage = [
      const SingleChildScrollView(child: CategoryRead()),
      const SingleChildScrollView(child: ProductsRead()),
      const SingleChildScrollView(child: TableRead()),
      const SingleChildScrollView(child: OrderPageRead()),
      SingleChildScrollView(child: SalesDashboardPage(widget.pageController)),
      const SingleChildScrollView(child: OrderHistoryPage()),
      const SingleChildScrollView(child: UserRead()),
    ];
    List<Widget> waiterPage = [
      const SingleChildScrollView(child: OrderPageRead()),
      const SingleChildScrollView(child: OrderHistoryPage()),
    ];

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        drawer: (MediaQuery.of(context).size.width<850)? SideMenuWidget(LocalPreference.getUserRole(),
            widget.pageController):null,
          appBar: AppBar(
           // automaticallyImplyLeading: false,
            title: Text(AppLocalizations.of(context)!.project_title),
            actions: [
              Row(
                children: [
                  const Text("English"),
                  Switch(
                    onChanged: (value) {
                      if ((LocalPreference.getLang() == "en")) {
                        setState(() {
                          LocalPreference.setLang("hi");
                          isSwitched = true;
                        });
                        BlocProvider.of<LocalizationBloc>(context)
                            .add(const changelanevent("hi"));
                      } else if (LocalPreference.getLang() == "hi") {
                        setState(() {
                          //   LocalPreference.setLang("en");
                          isSwitched = false;
                        });
                        BlocProvider.of<LocalizationBloc>(context)
                            .add(const changelanevent("en"));
                      }
                    },
                    value: isSwitched,
                    activeColor: Colors.orange,
                    activeTrackColor: Colors.orange.shade600,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.white,
                  ),
                  const Text("Hindi")
                ],
              ),
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
                 (MediaQuery.of(context).size.width>850)?Expanded(
                      flex: 1,
                      child: SideMenuWidget(LocalPreference.getUserRole(),
                          widget.pageController)):SizedBox(),
                  Expanded(
                    flex: 7,
                    child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: widget.pageController,
                        children: LocalPreference.getUserRole() == 'Admin'
                            ? adminPage
                            : waiterPage),
                  )
                ],
              ),
            )
          ]))),
    );
  }
}
