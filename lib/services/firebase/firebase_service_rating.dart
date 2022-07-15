// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServiceRating {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User get currentUser => _firebaseAuth.currentUser!;

  Future getDocTotalCount() async {
    QuerySnapshot _myDoc = await _firebaseFirestore
        .collection('Booking')
        .where("DoctorID", isEqualTo: _firebaseAuth.currentUser?.uid)
        // .where('rating',isGreaterThan: 0)
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    // print(_myDocCount.length);
    return _myDocCount.length;
  }

  Future get_5_Rating() async {
    QuerySnapshot _myDoc = await _firebaseFirestore
        .collection('Booking')
        .where("DoctorID", isEqualTo: _firebaseAuth.currentUser?.uid)
        .where('rating', isEqualTo: 5)
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    var total = await getDocTotalCount();
    // print(_myDocCount.length / total);
    return _myDocCount.length / total;
  }

  Future get_4_Rating() async {
    QuerySnapshot _myDoc = await _firebaseFirestore
        .collection('Booking')
        .where("DoctorID", isEqualTo: _firebaseAuth.currentUser?.uid)
        .where('rating', isEqualTo: 4)
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    var total = await getDocTotalCount();
    // print(_myDocCount.length / total);
    return _myDocCount.length / total;
  }

  Future get_3_Rating() async {
    QuerySnapshot _myDoc = await _firebaseFirestore
        .collection('Booking')
        .where("DoctorID", isEqualTo: _firebaseAuth.currentUser?.uid)
        .where('rating', isEqualTo: 3)
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    var total = await getDocTotalCount();
    // print(_myDocCount.length / total);
    return _myDocCount.length / total;
  }

  Future get_2_Rating() async {
    QuerySnapshot _myDoc = await _firebaseFirestore
        .collection('Booking')
        .where("DoctorID", isEqualTo: _firebaseAuth.currentUser?.uid)
        .where('rating', isEqualTo: 2)
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    var total = await getDocTotalCount();
    // print(_myDocCount.length / total);
    return _myDocCount.length / total;
  }

  Future get_1_Rating() async {
    QuerySnapshot _myDoc = await _firebaseFirestore
        .collection('Booking')
        .where("DoctorID", isEqualTo: _firebaseAuth.currentUser?.uid)
        .where('rating', isEqualTo: 1)
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    var total = await getDocTotalCount();
    // print(_myDocCount.length / total);
    return _myDocCount.length / total;
  }
}
