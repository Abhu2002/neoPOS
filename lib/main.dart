import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/category/category_operation/create_operation/create_category_bloc.dart';
import 'package:neopos/screens/category/category_operation/delete_operation/delete_bloc.dart';
import 'package:neopos/screens/category/category_operation/update_operation/category_update_bloc.dart';
import 'package:neopos/screens/category/category_page/read_category_bloc.dart';
import 'package:neopos/screens/dashboard/Localization%20bloc/localization_bloc.dart';
import 'package:neopos/screens/dashboard/dashboard_page.dart';
import 'package:neopos/screens/dashboard/side_menu_bloc.dart';
import 'package:neopos/screens/login/login_bloc.dart';
import 'package:neopos/screens/order%20page/order_menu_page/order_menu_bloc.dart';
import 'package:neopos/screens/order%20page/order_table_page/order_read_bloc.dart';
import 'package:neopos/screens/order%20history/order_history_bloc.dart';
import 'package:neopos/screens/products/products_operation/create_operation/create_product_bloc.dart';
import 'package:neopos/screens/products/products_operation/delete_operation/delete_bloc.dart';
import 'package:neopos/screens/products/products_operation/update_operation/product_update_bloc.dart';
import 'package:neopos/screens/products/products_page/read_products_bloc.dart';
import 'package:neopos/screens/sales_dashboard/sales_dashboard_bloc.dart';
import 'package:neopos/screens/sales_dashboard/widget/graph_widget/graph_dashboard_bloc.dart';
import 'package:neopos/screens/sales_dashboard/widget/top5_product_page/top5_bloc.dart';
import 'package:neopos/screens/splashScreen/splashscreen_page.dart';
import 'package:neopos/screens/users/user_operations/user_create/create_user_bloc.dart';
import 'package:neopos/screens/users/user_operations/user_delete/delete_user_bloc.dart';
import 'package:neopos/screens/users/user_operations/user_update/update_user_bloc.dart';
import 'package:neopos/screens/users/user_page/read_user_bloc.dart';
import 'package:neopos/screens/table/table_operation/create_operation/create_table_bloc.dart';
import 'package:neopos/screens/table/table_operation/delete_operation/delete_bloc.dart';
import 'package:neopos/screens/table/table_operation/update_operation/update_bloc.dart';
import 'package:neopos/screens/table/table_page/table_bloc.dart';
import 'package:neopos/utils/app_colors.dart';
import 'package:neopos/utils/sharedpref/sharedpreference.dart';
import 'di/firebase_di.dart';
import 'firebase_options.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'navigation/app_router.dart';

Future<void> main() async {
  setupSingletons();
  WidgetsFlutterBinding.ensureInitialized();
  LocalPreference.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

        ///Bloc for Product CRUD
        BlocProvider(create: (_) => ReadProductsBloc()),
        BlocProvider(create: (_) => CreateProductBloc()),
        BlocProvider(create: (_) => ProductDeletionBloc()),
        BlocProvider(create: (_) => UpdateProductBloc()),

        //Bloc for Order Page
        BlocProvider(create: (_) => OrderReadBloc()),
        BlocProvider(create: (_) => OrderContentBloc()),

        //Bloc for Order History Page
        BlocProvider(create: (_) => OrderHistoryBloc()),

        //Bloc for SalesDashboard page
        BlocProvider(create: (_) => SalesDashboardBloc()),
        BlocProvider(create: (_) => GraphDashboardBloc()),

        // Bloc for Sidebar
        BlocProvider(create: (_) => SideMenuBloc()),

        // Bloc for Localization
        BlocProvider(create: (_) => LocalizationBloc()),

        // Bloc for Top 5 Products
        BlocProvider(create: (_) => Top5Bloc()),
      ],
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: AppColors.primarySwatch,
                scaffoldBackgroundColor: AppColors.backgroundColor),
            home: LocalPreference.getSignWith() != null
                ? DashboardPage()
                : const SplashScreen(),

            onGenerateRoute: AppRouter.generateRoute,
            // setting up localization
            supportedLocales: L10n.all,
            locale: Locale((state is localInitial) ? state.lann : "en"),
            localizationsDelegates: [
              AppLocalizations.delegate,
              AppLocalizations.localizationsDelegates[1],
              AppLocalizations.localizationsDelegates[2],
              AppLocalizations.localizationsDelegates[3],
            ],
          );
        },
      ),
    );
  }
}



