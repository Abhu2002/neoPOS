import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/dashboard/side_menu_bloc.dart';

import 'package:neopos/utils/app_colors.dart';

import '../../utils/sharedpref/sharedpreference.dart';
import '../login/login_bloc.dart';
import 'dashboard_page.dart';

class SideMenuWidget extends StatefulWidget {
  var userRole;
  PageController pageController;

  SideMenuWidget(this.userRole, this.pageController,{Key? key,}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SideMenuPage();

}

class _SideMenuPage extends State<SideMenuWidget> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SideMenuBloc, SideMenuState>(builder: (context, state) {
      if (state is SideMenuLoaded) {
        index = state.index;
      }
      List<Widget> admin = [
        DrawerListTile(
          title: "Category",
          icon: Icon(
            Icons.category,
            color: (index == 0) ? AppColors.primarySwatch : Colors.black,
          ),
          press: () {
            widget.pageController.jumpToPage(0);
            BlocProvider.of<SideMenuBloc>(context).add(SideMenuInitEvent(0));
          },
          isSelected: index == 0,
        ),
        DrawerListTile(
          title: "Product",
          icon: Icon(
            Icons.restaurant_menu,
            color: (index == 1) ? AppColors.primarySwatch : Colors.black,
          ),
          press: () {
            BlocProvider.of<SideMenuBloc>(context).add(SideMenuInitEvent(1));
            widget.pageController.jumpToPage(1);
          },
          isSelected: index == 1,
        ),
        DrawerListTile(
          title: "Tables",
          icon: Icon(
            Icons.table_chart,
            color: (index == 2) ? AppColors.primarySwatch : Colors.black,
          ),
          press: () {
           widget.pageController.jumpToPage(2);
            BlocProvider.of<SideMenuBloc>(context).add(SideMenuInitEvent(2));
          },
          isSelected: index == 2,
        ),
        DrawerListTile(
          title: "Order page",
          icon: Icon(
            Icons.dashboard,
            color: (index == 3) ? AppColors.primarySwatch : Colors.black,
          ),
          press: () {
            widget.pageController.jumpToPage(3);
            BlocProvider.of<SideMenuBloc>(context).add(SideMenuInitEvent(3));
          },
          isSelected: index == 3,
        ),
        DrawerListTile(
          title: "Dashboard",
          icon: Icon(
            Icons.dashboard,
            color: (index == 4) ? AppColors.primarySwatch : Colors.black,
          ),
          press: () {
            widget.pageController.jumpToPage(4);
            BlocProvider.of<SideMenuBloc>(context).add(SideMenuInitEvent(4));
          },
          isSelected: index == 4,
        ),
        DrawerListTile(
          title: "Order History",
          icon: Icon(
            Icons.shopping_cart,
            color: (index == 5) ? AppColors.primarySwatch : Colors.black,
          ),
          press: () {
            widget.pageController.jumpToPage(5);
            BlocProvider.of<SideMenuBloc>(context).add(SideMenuInitEvent(5));
          },
          isSelected: index == 5,
        ),
        DrawerListTile(
          title: "Users",
          icon: Icon(
            Icons.category,
            color: (index == 6) ? AppColors.primarySwatch : Colors.black,
          ),
          press: () {
            widget.pageController.jumpToPage(6);
            BlocProvider.of<SideMenuBloc>(context).add(SideMenuInitEvent(6));
          },
          isSelected: index == 6,
        ),
      ];
      List<Widget> waiter = [
        DrawerListTile(
          title: "Order page",
          icon: Icon(
            Icons.dashboard,
            color: (index == 0) ? AppColors.primarySwatch : Colors.black,
          ),
          press: () {
            widget.pageController.jumpToPage(0);
            BlocProvider.of<SideMenuBloc>(context).add(SideMenuInitEvent(0));
          },
          isSelected: index == 0,
        ),
        DrawerListTile(
          title: "Order History",
          icon: Icon(
            Icons.shopping_cart,
            color: (index == 1) ? AppColors.primarySwatch : Colors.black,
          ),
          press: () {
            widget.pageController.jumpToPage(1);
            BlocProvider.of<SideMenuBloc>(context).add(SideMenuInitEvent(1));
          },
          isSelected: index == 1,
        ),
      ];
      return Drawer(
        child: ListView(
          children: LocalPreference.getUserRole() == 'Admin' ? admin : waiter,
        ),
      );
    });
  }


}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.press,
  }) : super(key: key);

  final String title;
  final Icon icon;
  final bool isSelected;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: (isSelected) ? AppColors.primarySwatch.shade50 : null,
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: icon,
      title: (MediaQuery.of(context).size.width < 900)
          ? null
          : Text(
              title,
              style: TextStyle(
                  color: (isSelected)
                      ? AppColors.primarySwatch.shade400
                      : Colors.black),
            ),
    );
  }
}
