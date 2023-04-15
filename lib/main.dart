import 'package:admin_panel/featured/auth/screen/auth_screen.dart';
import 'package:admin_panel/routes.dart';
import 'package:flutter/material.dart';

import 'constant/global_variable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        )
      ),
      onGenerateRoute: (settings) => generateRoutes( settings),
      home: const AuthScreen(),
    );
  }
}