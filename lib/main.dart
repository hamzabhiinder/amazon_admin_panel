import 'package:admin_panel/common/bottom_bar.dart';
import 'package:admin_panel/common/loader.dart';
import 'package:admin_panel/featured/SplashScreen/splash_screen.dart';
import 'package:admin_panel/featured/auth/screen/auth_screen.dart';
import 'package:admin_panel/featured/cart/screen/cart_screen.dart';
import 'package:admin_panel/featured/home/screen/home_screen.dart';
import 'package:admin_panel/provider/user_provider.dart';
import 'package:admin_panel/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constant/global_variable.dart';
import 'featured/admin/screen/admin_screen.dart';
import 'featured/auth/screen/register_screen.dart';
import 'featured/auth/services/auth_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ShowLoader()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        onGenerateRoute: (settings) => generateRoutes(settings),
        home: SplashScreen() //SignUpScreen(),
        // home: Provider.of<UserProvider>(context).user.token.isNotEmpty
        // ? Provider.of<UserProvider>(context).user.type == "user"
        //     ? const BottomBar()
        //     : const AdminScreen()
        // : const AuthScreen(),
        // //  home: Provider.of<UserProvider>(context).user.token.isNotEmpty
        //     ? Provider.of<UserProvider>(context).user.type == "user"
        //         ? const SplashScreen(firstLetter: "BO")
        //         : const SplashScreen(firstLetter: "AD",)
        //     : const SplashScreen(firstLetter: "AU",) ,
        );
  }
}
