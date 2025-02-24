import 'package:e_commerce_app/core/routes/routes_name.dart';
import 'package:e_commerce_app/ui/auth/sign_in_screen.dart';
import 'package:e_commerce_app/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../ui/auth/sign_up_screen.dart';

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

      default:
        return MaterialPageRoute(
          builder: (context) => SplashScreen() ,
          settings: settings,
        );
    }

  }

}
