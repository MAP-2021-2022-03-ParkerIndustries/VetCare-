import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_mvvm/service_stream.dart';

import '../../model/booking.dart';

class FirebaseServiceBookingHistory with ServiceStream{
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
   
  
   @override
  Stream? get stream => FirebaseFirestore.instance
      .collection('Booking')
      .where("customerID", isEqualTo: _firebaseAuth.currentUser?.uid)
      .snapshots();
}