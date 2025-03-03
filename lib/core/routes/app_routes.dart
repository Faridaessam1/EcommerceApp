import 'package:e_commerce_app/core/routes/routes_name.dart';
import 'package:e_commerce_app/ui/auth/signIN/sign_in_screen.dart';
import 'package:e_commerce_app/ui/home/home_layout_view.dart';
import 'package:e_commerce_app/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../ui/auth/SignUp/sign_up_screen.dart';

class AppRoutes{
  static Route onGenerateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.initial:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
          settings: settings,
        );
      case RoutesName.signIn:
        return MaterialPageRoute(
          builder: (context) =>SignInScreen(),
          settings: settings,
        );
      case RoutesName.signUp:
        return MaterialPageRoute(
          builder: (context) =>SignUpScreen(),
          settings: settings,
        );
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (context) => HomeLayoutView(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => SplashScreen() ,
          settings: settings,
        );
    }

  }

}
