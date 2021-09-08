import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maan_api_project/addnewproduct/addnewProductPade.dart';
import 'package:maan_api_project/bottomNavigationBar/provider.dart';
import 'package:maan_api_project/cart/data/sqlite_helper.dart';
import 'package:maan_api_project/cart/provider/database_provider.dart';
import 'package:maan_api_project/helpers/route_helper.dart';
import 'package:maan_api_project/providers/productDetailProvider.dart';
import 'package:maan_api_project/themeHelper/themeProvider.dart';
import 'package:maan_api_project/ui/Home.dart';
import 'package:maan_api_project/providers/homeProvider.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await DBHelper.cartHelper.initDatabase();
  
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider<ProductDetailsProvider>(
          create: (context) => ProductDetailsProvider(),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (context) => DatabaseProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        )
      ],
      child: EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path:
            'assets/translation', 
        fallbackLocale: Locale('en'),
        child:MyApp1()
      ),
    );
  }
}
class MyApp1 extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            navigatorKey: RouteHelper.routeHelper.navKey,
            theme: ThemeData(
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: Colors.white,
                    selectedItemColor: Colors.purple)),
            debugShowCheckedModeBanner: false,
            home: Home());
            
  }
}