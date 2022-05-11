import 'package:flutter/material.dart';

// need homepage/login/register ui first

class Routes {
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';

  static Route<dynamic>? createRoute(settings) {
    switch (settings.name) {
      case homeRoute:
      // return HomeScreen.route();
      case loginRoute:
      // return loginRoute.route();
      case registerRoute:
      // return loginRoute.route();

    }
    return null;
  }
}
