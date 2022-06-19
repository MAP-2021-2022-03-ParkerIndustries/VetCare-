import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:map_mvvm/viewmodel.dart';
import 'package:vetclinic/model/vet.dart';
import 'package:vetclinic/services/firebase/firebase_service.dart';
import 'package:vetclinic/app/service_locator.dart';
import 'package:vetclinic/model/booking.dart';
import 'package:vetclinic/services/firebase/firebase_service_booking.dart';

import '../../../model/Users.dart';


class BookingViewModel extends Viewmodel {
  FirebaseService get _service => locator <FirebaseService>();
  Users _users = Users();
  Booking _booking = Booking();
 FirebaseServiceBooking get _serviceBooking => locator <FirebaseServiceBooking>();
  Vet _vet = Vet();
 
@override
void init() async {
    super.init();
    notifyListenersOnFailure = true;

    await update(
      () async {
        try {
          (await _service.readUsers());
        } on Failure{rethrow;}
      },
    );
  }

void create(model) async{
  
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
  _booking.dateBooking= formattedDate;
  _booking.PaymentValue_Admin=5;
  _booking.PaymentValue_Doctor=50;

  _users= await _service.readUsers();
  _booking.customerID= _users.email;
  _serviceBooking.MakeBooking(_booking);
  

}
}
