import 'package:flutter/cupertino.dart';
import 'package:neopos/navigation/route_paths.dart';

import '../screens/dashboard/dashboard_page.dart';
import '../screens/login/login_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // -------------- sub Routes ----------------
      case RoutePaths.dashboard:
        return CupertinoPageRoute(
          builder: (context) => const DashboardPage( ),
          settings: const RouteSettings(name: RoutePaths.dashboard),
        );
      case RoutePaths.login:
        return CupertinoPageRoute(
          builder: (context) => const LoginPage(),
          settings: const RouteSettings(name: RoutePaths.login),
        );
      default:
        return CupertinoPageRoute(
          builder: (context) => Container(),
        );
    }
  }
}
