import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_mvvm/failure.dart';

import '../../model/booking.dart';

class FirebaseServiceBooking{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //firebase cloud function for booking and users relation
  //Booking CRUD
  @override
  Future<void> MakeBooking(Booking booking) async {
    try {
      var book = await _firebaseFirestore
          .collection("Booking")
          .doc()
          .set(booking.toJson());
    } on Failure catch (e) {
      throw Failure(
        400,
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> cancelBooking(Booking booking) async {
    try {
      var cbook = await _firebaseFirestore
          .collection("Booking")
          .doc().delete();

    } on Failure catch (e) {
      throw Failure(
        400,
        message: e.toString(),
      );
    }
  }
}