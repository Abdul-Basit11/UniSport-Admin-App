import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:unisport_admin_app/utils/helper/helper_function.dart';
import 'package:unisport_admin_app/view/home/dashboard_view/dashboard_screen.dart';

import '../login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      checkUser();
      // BHelperFunction.navigate(context, LoginScreen());
    });
  }

  checkUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.offAll(() => DashboardScreen());
    } else {
      Get.to(() => LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            // Image.asset(ImageString.splashLogo),
            Text(
              'Admin App',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
