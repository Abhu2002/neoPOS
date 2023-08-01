import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neopos/navigation/route_paths.dart';
import '../screens/dashboard/dashboard_page.dart';
import '../screens/login/login_page.dart';
import '../screens/table/table_operation/table_read/table_home.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
    // -------------- sub Routes ----------------
    // -------------- Dasboard Route ------------
      case RoutePaths.dashboard:
        return MaterialPageRoute(
          builder: (context) => const DashboardPage(),
          settings: const RouteSettings(name: RoutePaths.dashboard),
        );
    // -------------- Login Route ---------------
      case RoutePaths.login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
          settings: const RouteSettings(name: RoutePaths.login),
        );
    // -------------- table Route ---------------
      case RoutePaths.table:
        return CupertinoPageRoute(
          builder: (context) => const HomeRead(),
          settings: const RouteSettings(name: RoutePaths.table),
        );
    // -------------- Default Route -------------
      default:
        return MaterialPageRoute(
          builder: (context) => Container(),
        );
    }
  }
}