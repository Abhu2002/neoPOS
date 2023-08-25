import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/dashboard/side_menu.dart';
import 'package:neopos/screens/login/login_bloc.dart';

import 'package:neopos/screens/products/products_page/read_products_page.dart';
import 'package:neopos/screens/sales_dashboard/mob_sales_dashboard/mob_sales_dashboard.dart';
import '../../navigation/route_paths.dart';
import '../../utils/sharedpref/sharedpreference.dart';
import '../category/mob_category_page/read_mob_category_page.dart';
import '../order history/order_history_page.dart';
import '../order page/order_table_page/order_read_page.dart';
import '../products/products_page/products_mobile_page/read_products_mobile_page.dart';
import '../sales_dashboard/sales_dashboard_page.dart';
import '../table/table_page/table_page.dart';
import '../category/category_page/read_category_page.dart';
import '../users/mob_user_page/read_mob_user_page.dart';
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
      SingleChildScrollView(
          child: (MediaQuery.sizeOf(context).width > 850)
              ? const CategoryRead()
              : const CategoryMobileRead()),
      SingleChildScrollView(
          child: (MediaQuery.sizeOf(context).width > 850)
              ? const ProductsRead()
              : const ProductMobileRead()),
      const SingleChildScrollView(child: TableRead()),
      const SingleChildScrollView(child: OrderPageRead()),
      SingleChildScrollView(
          child: (MediaQuery.sizeOf(context).width > 850)
              ? SalesDashboardPage(widget.pageController)
              : MobileSalesDashboardPage(widget.pageController)),
      const SingleChildScrollView(child: OrderHistoryPage()),
      SingleChildScrollView(
          child: (MediaQuery.sizeOf(context).width > 850)
              ? const UserRead()
              : const UserMobileRead()),
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
          drawer: (MediaQuery.of(context).size.width < 850)
              ? SideMenuWidget(
                  LocalPreference.getUserRole(), widget.pageController)
              : null,
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            title: Text(AppLocalizations.of(context)!.project_title),
            actions: [
              PopupMenuButton<String>(
                tooltip: "Language Settings",
                icon: const Icon(Icons.language),
                onSelected: (choice){
                  if(choice == "Hindi") {
                    setState(() {
                      LocalPreference.setLang("hi");
                    });
                    BlocProvider.of<LocalizationBloc>(context)
                        .add(const changelanevent("hi"));
                  } else {
                    setState(() {
                      LocalPreference.setLang("en");
                    });
                    BlocProvider.of<LocalizationBloc>(context)
                        .add(const changelanevent("en"));
                  }
                },
                itemBuilder: (BuildContext context) {
                  return Constants.choices.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
              IconButton(
                onPressed: () async {
                  String? oldLan = LocalPreference.getLang();
                  LocalPreference.clearAllPreference();
                  LocalPreference.setLang(oldLan);
                  Navigator.pushReplacementNamed(context, RoutePaths.login);
                },
                icon: const Icon(Icons.logout),
              )
            ],
          ),
          body: SafeArea(
              child: CustomScrollView(slivers: [
            SliverFillRemaining(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  (MediaQuery.of(context).size.width > 850)
                      ? Expanded(
                          flex: 1,
                          child: SideMenuWidget(LocalPreference.getUserRole(),
                              widget.pageController))
                      : SizedBox(),
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

class Constants {
  static const String FirstLang = 'Hindi';
  static const String SecondLang = 'English';

  static const List<String> choices = <String>[
    FirstLang,
    SecondLang,
  ];
}