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

void main()  {
  // تأكد من تهيئة Flutter bindings قبل أي async operations
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies(); // ← دي أهم خطوة
  Bloc.observer = MyBlocObserver();

  // تهيئة Loading configuration قبل runApp
  ConfigLoading();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.home,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      navigatorKey: navigatorKey,
      builder: (context, child) {
        child = EasyLoading.init()(context, child);
        child = BotToastInit()(context, child);
        return child;
      },
    );
  }
}