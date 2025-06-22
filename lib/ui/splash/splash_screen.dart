import 'dart:async';
import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../core/routes/routes_name.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(
          seconds: 5,
        ),

            () {
          Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.signIn, (route) => false,
          );
        }

    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor:AppColors.primaryColor,
        body: Center(
          child: Image.asset(AppAssets.appLogo),
        )

    );
  }
}