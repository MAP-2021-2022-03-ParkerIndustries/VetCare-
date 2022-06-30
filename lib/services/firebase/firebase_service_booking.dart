
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_mvvm/failure.dart';
import 'package:map_mvvm/service_stream.dart';

import '../../model/booking.dart';

class FirebaseServiceBooking with ServiceStream  {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //firebase cloud function for booking and users relation
  @override
  Stream? get stream => FirebaseFirestore.instance
      .collection('Users')
      .where("role", isEqualTo: "vet")
      .snapshots();


  //Booking CRUD
  @override
  Future<void> MakeBooking(Booking booking) async {
    try {
      // var book = await _firebaseFirestore.collection("Booking")
      // .doc()
      // .set(booking.toJson());

      var book= _firebaseFirestore.collection("Booking").doc();
      await book.set(
       { 'bookingID': book.id}

      );
       _firebaseFirestore.collection("Booking").doc(book.id).update(booking.toJson());

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
      var cbook = await _firebaseFirestore.collection("Booking").doc().delete();
    } on Failure catch (e) {
      throw Failure(
        400,
        message: e.toString(),
      );
    }
  }
}
