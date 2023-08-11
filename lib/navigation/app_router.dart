import 'package:flutter/cupertino.dart';
import 'package:neopos/navigation/route_paths.dart';
import '../screens/dashboard/dashboard_page.dart';
import '../screens/login/login_page.dart';
import '../screens/order page/order_menu_page/order_menu_page.dart';
import '../screens/splashScreen/splashscreen_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // -------------- sub Routes ----------------
      // -------------- splashscreen Route ------------
      case RoutePaths.splashscreen:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
          settings: const RouteSettings(name: RoutePaths.splashscreen),
        );
      // -------------- Menuscreen Route ------------
      case RoutePaths.menu:
        return CupertinoPageRoute(
          builder: (context) => OrderMenuPage(data: settings.arguments),
          settings: RouteSettings(
              name: RoutePaths.menu, arguments: settings.arguments),
        );
      // -------------- Dasboard Route ------------
      case RoutePaths.dashboard:
        return CupertinoPageRoute(
          builder: (context) => const DashboardPage(),
          settings: const RouteSettings(name: RoutePaths.dashboard),
        );
      // -------------- Login Route ---------------
      case RoutePaths.login:
        return CupertinoPageRoute(
          builder: (context) => const LoginPage(),
          settings: const RouteSettings(name: RoutePaths.login),
        );
      // -------------- Default Route -------------
      default:
        return CupertinoPageRoute(
          builder: (context) => Container(),
        );
    }
  }
}
