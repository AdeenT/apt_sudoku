import 'dart:async';

import 'package:apt_sudoku/main.dart';
import 'package:apt_sudoku/screens/home_screen.dart';
import 'package:apt_sudoku/signupin/name_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () => keepUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/splashlogo.png',
              height: 210.0,
              width: 210.0,
            ),
            const CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
          ],
        ),
      ),
    );
  }

  void keepUserLoggedIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final userLoggedIn = sharedPreferences.getBool(userKey);
    if (userLoggedIn == null || userLoggedIn == false) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }
}
