import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/repository/tables_read.dart';
import 'package:neopos/screens/category/category_operation/create_operation/create_category_bloc.dart';
import 'package:neopos/screens/category/category_operation/delete_operation/delete_bloc.dart';
import 'package:neopos/screens/category/category_operation/update_operation/category_update_bloc.dart';
import 'package:neopos/screens/category/category_page/read_category_bloc.dart';
import 'package:neopos/screens/dashboard/dashboard_page.dart';
import 'package:neopos/screens/login/login_bloc.dart';
import 'package:neopos/screens/login/login_page.dart';
import 'package:neopos/screens/table/table_operation/table_read/table_bloc.dart';
import 'package:neopos/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'navigation/app_router.dart';


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
        BlocProvider(create: (_) => ReadCategoryBloc()),
        BlocProvider(create: (_) => CreateCategoryBloc()),
        BlocProvider(create: (_) => CategoryDeletionBloc()),
        BlocProvider(create: (_) => CategoryUpdateBloc()),
        Provider(create: (_) => TablesRepository()),
        BlocProvider(create: (_) => TableBloc()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: AppColors.primarySwatch,
            scaffoldBackgroundColor: AppColors.backgroundColor),
        home: isLoggedIn(),
        onGenerateRoute: AppRouter.generateRoute,
        // setting up localization
        supportedLocales: L10n.all,
        locale: const Locale('en'),
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
