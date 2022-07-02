import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/app/service_locator.dart';
import 'package:vetclinic/services/firebase/firebase_service_vet_booking_list.dart';

import '../../../services/firebase/firebase_service.dart';

class UpdateBookingDetailVM extends Viewmodel{
  FirebaseService get _service => locator<FirebaseService>();
  FirebaseServiceVetBooking get _vetBookingService =>
      locator<FirebaseServiceVetBooking>();

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
    await update(() async {
      try {} catch (e) {}
    });
  }

  Future<void> updateData(dynamic bookingID,dynamic appointmentStatus,dynamic notes) async {
    _vetBookingService.updateBookingStatus(bookingID, appointmentStatus,notes);
  }
  
}