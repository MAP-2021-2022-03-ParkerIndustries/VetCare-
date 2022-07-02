import 'package:flutter/material.dart';
import 'package:vetclinic/ui/screen/Receptionist_home/Receptionist_home_viewmodel.dart';
import 'package:vetclinic/ui/screen/booking/booking_view.dart';
import 'package:vetclinic/ui/screen/booking/booking_view_v2.dart';
import 'package:vetclinic/ui/screen/customer_home/customer_home_view.dart';
import 'package:vetclinic/ui/screen/customer_home/customer_nav_view.dart';
import 'package:vetclinic/ui/screen/forgot_password/forgot_password_view.dart';
import 'package:vetclinic/ui/screen/history/history_view.dart';
import 'package:vetclinic/ui/screen/login/login_view.dart';
import 'package:vetclinic/ui/screen/profile/profile_view.dart';
import 'package:vetclinic/ui/screen/register/register_view.dart';
import 'package:vetclinic/ui/screen/register_pet/register_pet_view.dart';
import 'package:vetclinic/ui/screen/vet_booking_list/booking_list_view.dart';
import 'package:vetclinic/ui/screen/vet_home/vet_home_view.dart';
import 'package:vetclinic/ui/screen/vet_update_booking/update_booking_detail_appbar.dart';
import 'package:vetclinic/ui/screen/view_pet/petlist_view.dart';

import '../ui/screen/Rep/Receptionist_edit_view.dart';
import '../ui/screen/vet_update_booking/update_booking_detail_view.dart';

import '../ui/screen/Receptionist_home/Receptionist_home_view.dart';


class Routes {
  static const String customerHomeRoute = '/customerHome';
  static const String customerNavRoute = '/customerNav';
  static const String vetHomeRoute = '/vetHome';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPassRoute = '/forgotPass';
  static const String profileRoute = '/profile';
  static const String historyRoute = '/history';
  static const String registerPetRoute='/registerPet';
  static const String bookingPetRoute= '/booking';
  static const String vetBookingListRoute= '/vetBookingList';
  static const String receptionistHomeRoute = '/ReceptionistHome';
  static const String updateBookingDetailRoute= '/updateBookingDetailRoute';
  static const String receptionistEditRoute = '/ReceptionistEdit';
  static const String viewPetList = '/viewPetList';
  static const String makeBookV2='/makeBook';

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
      
      case vetBookingListRoute:
      return VetBookingListView.route();
      
      case registerPetRoute:
      return RegisterPetView.route();
     
      // case bookingPetRoute:
      // return BookingView.route();

      // case updateBookingDetailRoute:
      // return UpdateBookingDetailView.route();
      
      case receptionistHomeRoute:
      return ReceptionistHomeView.route();
      
      case receptionistEditRoute:
      return ReceptionistEditBookingView.route();
     
      case viewPetList:
      return PetListView.route();
      
      case makeBookV2:
      return MakeBookingView.route();
      
    }
    return null;
  }
}
