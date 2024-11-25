// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rajshai_town/Screen/bottom_nav/bottom_nav_bar.dart';
// import 'package:rajshai_town/auth/auth_sevices.dart';
// import 'package:rajshai_town/auth/login_page.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _checkLoginState();
//   }
//
//   void _checkLoginState() {
//     Timer(const Duration(seconds: 3), () {
//       final isLoggedIn = AuthService().isUserLoggedIn();
//       if (isLoggedIn) {
//         Get.off(() => const CustomBottomNavBar()); // Navigate to main screen
//       } else {
//         Get.off(() => LoginPage()); // Navigate to login screen
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Image in a circular shape
//             Container(
//               height: 130,
//               width: 130,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                   image: AssetImage("assets/images/railget.jpg"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Welcome to Rajshahi",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rajshai_town/Screen/bottom_nav/bottom_nav_bar.dart';
import 'package:rajshai_town/auth/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  void _checkLoginState() {
    Timer(const Duration(seconds: 3), () {
      final isLoggedIn = Supabase.instance.client.auth.currentUser != null;
      if (isLoggedIn) {
        Get.off(() => const CustomBottomNavBar());
      } else {
        Get.off(() => const LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image in a circular shape
            Container(
              height: 130,
              width: 130,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/images/railget.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Welcome to Rajshahi",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
