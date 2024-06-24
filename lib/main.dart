import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_admin_project/auth/login.dart';
import 'package:grocery_admin_project/screens/admin_users.dart';
import 'package:grocery_admin_project/screens/category_screen.dart';
import 'package:grocery_admin_project/screens/delivery_boy_screen.dart';

import 'package:grocery_admin_project/screens/manage_banners.dart';
import 'package:grocery_admin_project/screens/order_screen.dart';
import 'package:grocery_admin_project/screens/settings.dart';
import 'package:grocery_admin_project/screens/splash_screen.dart';
import 'package:grocery_admin_project/screens/vendors_screen.dart';

void main() async {
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCOG5LK5teUWsQ_QojoGaMNzLZ5khJ230s",
    appId: "1:727277842842:web:67fb7a3a2cad50ae0d0a23",
    messagingSenderId: "727277842842",
    projectId: "grocery-app-980ba",
        storageBucket: "grocery-app-980ba.appspot.com"
  ));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.green, useMaterial3: true),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        BannerScreen.id: (context) => BannerScreen(),
        CategoryScreen.id: (context) => CategoryScreen(),
        OrderScreen.id: (context) => OrderScreen(),

        AdminUsersScreen.id: (context) => AdminUsersScreen(),
        SettingScreen.id: (context) => SettingScreen(),
        VendorScreen.id: (context) => VendorScreen(),
        DeliveryBoyScreen.id: (context) => DeliveryBoyScreen(),
      },
    );
  }
}
