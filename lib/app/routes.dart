import 'package:flutter/material.dart';
import 'package:vetclinic/ui/screen/customer_home/customer_home_view.dart';
import 'package:vetclinic/ui/screen/customer_home/customer_nav_view.dart';
import 'package:vetclinic/ui/screen/forgot_password/forgot_password_view.dart';
import 'package:vetclinic/ui/screen/history/history_view.dart';
import 'package:vetclinic/ui/screen/login/login_view.dart';
import 'package:vetclinic/ui/screen/profile/profile_view.dart';
import 'package:vetclinic/ui/screen/register/register_view.dart';
import 'package:vetclinic/ui/screen/vet_home/vet_home_view.dart';


class Routes {
  static const String customerHomeRoute = '/customerHome';
  static const String customerNavRoute = '/customerNav';
  static const String vetHomeRoute = '/vetHome';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPassRoute = '/forgotPass';
  static const String profileRoute = '/profile';
  static const String historyRoute = '/history';
  

  static Route<dynamic>? createRoute(settings) {
    switch (settings.name) {
      case customerHomeRoute:
        return CustomerHomeView.route();

      case customerNavRoute:
        return CustomerNavView.route();

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

      case historyRoute :
        return HistoryView.route();
      
    }
    return null;
  }
}
