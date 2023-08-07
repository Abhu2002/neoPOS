import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/category/category_operation/create_operation/create_category_bloc.dart';
import 'package:neopos/screens/category/category_operation/delete_operation/delete_bloc.dart';
import 'package:neopos/screens/category/category_operation/update_operation/category_update_bloc.dart';
import 'package:neopos/screens/category/category_page/read_category_bloc.dart';
import 'package:neopos/screens/dashboard/dashboard_page.dart';
import 'package:neopos/screens/login/login_bloc.dart';
import 'package:neopos/screens/products/products_operation/delete_operation/delete_bloc.dart';
import 'package:neopos/screens/products/products_operation/update_operation/product_update_bloc.dart';
import 'package:neopos/screens/products/products_page/read_products_bloc.dart';
import 'package:neopos/screens/splashScreen/splashscreen_page.dart';
import 'package:neopos/screens/users/user_operations/user_create/create_user_bloc.dart';
import 'package:neopos/screens/users/user_operations/user_delete/delete_user_bloc.dart';
import 'package:neopos/screens/users/user_operations/user_update/update_user_bloc.dart';
import 'package:neopos/screens/users/user_page/read_user_bloc.dart';
import 'package:neopos/screens/table/table_operation/create_operation/create_table_bloc.dart';
import 'package:neopos/screens/table/table_operation/delete_operation/delete_bloc.dart';
import 'package:neopos/screens/table/table_operation/update_operation/update_bloc.dart';
import 'package:neopos/screens/table/table_page/table_bloc.dart';
import 'package:neopos/screens/products/products_operation/create_operation/create_product_bloc.dart';
import 'package:neopos/utils/app_colors.dart';
import 'di/firebase_di.dart';
import 'firebase_options.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'navigation/app_router.dart';

Future<void> main() async {
  setupSingletons();
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
        ///Bloc for Login
        BlocProvider(create: (_) => LoginBloc()),

        ///Bloc for Category CRUD
        BlocProvider(create: (_) => ReadCategoryBloc()),
        BlocProvider(create: (_) => CreateCategoryBloc()),
        BlocProvider(create: (_) => CategoryDeletionBloc()),
        BlocProvider(create: (_) => CategoryUpdateBloc()),

        ///Bloc for User CRUD
        BlocProvider(create: (_) => CreateUserBloc()),
        BlocProvider(create: (_) => UpdateUserBloc()),
        BlocProvider(create: (_) => ReadUserBloc()),
        BlocProvider(create: (_) => UserDeletionBloc()),

        ///Bloc for Table CRUD
        BlocProvider(create: (_) => TableBloc()),
        BlocProvider(create: (_) => TableDeletionBloc()),
        BlocProvider(create: (_) => CreateTableBloc()),
        BlocProvider(create: (_) => TableUpdateBloc()),

        //Bloc for Product CRUD
        BlocProvider(create: (_) => ReadProductsBloc()),
        BlocProvider(create: (_) => CreateProductBloc()),
        BlocProvider(create: (_) => ProductDeletionBloc()),
        BlocProvider(create: (_) => UpdateProductBloc()),
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
    widget = const SplashScreen();
  } else {
    widget = const DashboardPage();
  }
  return widget;
}
