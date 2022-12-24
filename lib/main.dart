import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:apt_sudoku/model/user_model.dart';
import 'package:apt_sudoku/screens/splash_screen.dart';
import 'package:get/get.dart';

const userKey = 'keep user logged in';
Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
