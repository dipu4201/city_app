import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rajshai_town/Screen/bottom_nav/bottom_nav_bar.dart';
import 'package:rajshai_town/Screen/splash_screen.dart';
import 'package:rajshai_town/auth/login_page.dart';
import 'package:rajshai_town/auth/sign_up_page.dart';

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: isLoggedIn ? '/home' : '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => CustomBottomNavBar(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
      },
    );
  }
}
