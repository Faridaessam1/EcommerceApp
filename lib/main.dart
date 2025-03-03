import 'package:bot_toast/bot_toast.dart';
import 'package:e_commerce_app/core/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'core/di/di.dart';
import 'core/routes/app_routes.dart';
import 'core/utils/loading_services.dart';
import 'core/utils/my_bloc_observer.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
  ConfigLoading();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RoutesName.home,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      navigatorKey: navigatorKey,
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
    );
  }
}
