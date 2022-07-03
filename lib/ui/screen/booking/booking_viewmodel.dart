import 'dart:async';

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
import 'notification_api.dart';

class BookingViewModel extends Viewmodel {
  FirebaseService get _service => locator<FirebaseService>();
  Users _users = Users();
  Booking _booking = Booking();
  FirebaseServiceBooking get _serviceBooking =>
      locator<FirebaseServiceBooking>();
  List<Users> listVet = [];
  StreamSubscription? _bookingServiceStreamListener;
  Users selectedVet = Users();
  @override
  void init() async {
    super.init();
    NotificationApi.init(initScheduled: true);

    await update(
      () async {
        try {

          _users = await _service.readUsers();
        } on Failure {
          rethrow;
        }
      },
    );
    _bookingServiceStreamListener = _serviceBooking.listen(
      onDone: dispose,
      onData: (_data) async {
        await update(
          () async {
            //reset listVet
            listVet = [];
            //transform querysnapshot => List<Vet>
            for (var element in _data.docs) {
              listVet
                  .add(Users.fromJson(element.data() as Map<String, dynamic>));
            }
          },
        );
      },
      onError: (e) {
        catchError(Failure(401,
            message: e.toString(),
            location:
                'BookingViewmodel.onData.streamListener on other exceptions'));
      },
    );
  }

  void create(selectedVet, choosenPet, selectedDate,paymentType) async {
    // DateTime now = DateTime.now();

    // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    try {
      await update(() async {
        _booking.dateBooking = selectedDate.millisecondsSinceEpoch;

        _booking.PaymentValue_Admin = 5;
        _booking.PaymentValue_Doctor = 50;
        _booking.petID = choosenPet.petID;
        _booking.DoctorID = selectedVet.userID;
        _booking.customerID = await _service.getUserId();
        _booking.appointmentStatus='Booked';
        _booking.paymentType=paymentType;
        _booking.notes='-';
        _booking.rating=0.0;
        await _serviceBooking.MakeBooking(_booking);
      });
    } on Failure {
      rethrow;
    }
  }

  void selectVet(vet) {
    selectedVet = vet;
  }

  @override
  void dispose() {
    _bookingServiceStreamListener?.cancel();
    _bookingServiceStreamListener = null;
    super.dispose();
  }
}
