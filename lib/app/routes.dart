import 'package:flutter/material.dart';
import 'package:vetclinic/ui/view/forgot_password_view.dart';
import 'package:vetclinic/ui/view/vet_home_view.dart';
import 'package:vetclinic/ui/view/login_view.dart';
import 'package:vetclinic/ui/view/profile_view.dart';
import 'package:vetclinic/ui/view/register_view.dart';

import '../ui/view/customer_home_view.dart';

class Routes {
  static const String customerHomeRoute = '/customerHome';
  static const String vetHomeRoute = '/vetHome';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPassRoute = '/forgotPass';
  static const String profileRoute = '/profile';

  static Route<dynamic>? createRoute(settings) {
    switch (settings.name) {
      case customerHomeRoute:
        return CustomerHomeView.route();

      case vetHomeRoute:
        return VetHomeView.route();

      case registerRoute:
        return RegisterView.route();

      case loginRoute :
        return LoginView.route();

      case forgotPassRoute :
        return ForgotPasswordView.route();
      
      case profileRoute :
        return ProfileView.route();
      
    }
    return null;
  }
}
