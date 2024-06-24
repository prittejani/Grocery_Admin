import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:grocery_admin_project/auth/login.dart';
import 'package:grocery_admin_project/screens/vendors_screen.dart';
import 'package:grocery_admin_project/utils/constants/custom_progress_indicator.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String id = 'splash-screen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      FirebaseAuth.instance
          .authStateChanges()
          .listen((User? user) {
        if (user == null) {
          Get.offNamed(LoginScreen.id);
        } else {
          Get.offNamed(VendorScreen.id);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: customProgressIndicator()
        //CircularProgressIndicator(),
      ),
    );
  }
}
