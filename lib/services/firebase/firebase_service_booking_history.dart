import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_mvvm/map_mvvm.dart';

class FirebaseServiceBookingHistory with ServiceStream {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
   
  
   @override
  Stream? get stream => FirebaseFirestore.instance
      .collection('Booking')
      .where("customerID", isEqualTo: _firebaseAuth.currentUser?.uid)
      .snapshots();

  Future<void> updateRating(dynamic bookingID, dynamic rating) async {
    try {
      final doc = FirebaseFirestore.instance.doc('Booking/$bookingID');
      doc.update({'rating': rating});
    } catch (e) {
      throw Failure(
        101,
        message: e.toString(),
      );
    }
  }
}
