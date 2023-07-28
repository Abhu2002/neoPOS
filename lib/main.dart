import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/dashboard/dashboard_page.dart';
import 'package:neopos/screens/login/login_bloc.dart';
import 'package:neopos/screens/login/login_page.dart';
import 'package:neopos/screens/table/table_operation/create_table/create_table_bloc.dart';
import 'package:neopos/utils/app_colors.dart';
import 'firebase_options.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor));

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => CreateTableBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: AppColors.primarySwatch,
            scaffoldBackgroundColor: AppColors.backgroundColor),
        home: isLoggedIn(),

        // setting up localization
        supportedLocales: L10n.all,
        locale: const Locale('hi'),
        localizationsDelegates: [
          AppLocalizations.delegate,
          AppLocalizations.localizationsDelegates[1],
          AppLocalizations.localizationsDelegates[2],
          AppLocalizations.localizationsDelegates[3],
        ],
      ),
    );
  }
}

Widget? isLoggedIn() {
  Widget? widget;

  /// TODO: Initialize user to check whether already logged in or not
  const user = null;
  if (user == null) {
    widget = const LoginPage();
  } else {
    widget = const DashboardPage();
  }
  return widget;
}
