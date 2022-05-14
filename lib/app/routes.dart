import 'package:flutter/material.dart';
import 'package:vetclinic/ui/screens/home/home_view.dart';

import '../ui/screens/login/login_view.dart';

class Routes {
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';

  static Route<dynamic>? createRoute(settings) {
    switch (settings.name) {
      case homeRoute:
        return HomeScreen.route();
      case loginRoute:
        return LoginScreen.route();
      case registerRoute:
      // return RegisterRoute.route();

    }
    return null;
  }
}
