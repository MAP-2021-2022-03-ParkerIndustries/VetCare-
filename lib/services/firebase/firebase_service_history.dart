
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_mvvm/failure.dart';
import 'package:map_mvvm/service_stream.dart';

import '../../model/history.dart';


class FirebaseServiceHistory with ServiceStream{

    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User get currentUser => _firebaseAuth.currentUser!;
    // history stream
  // Stream? snapHistory() {
  //   return FirebaseFirestore.instance
  //       .collection("History")
  //       .where("customerID", isEqualTo: _firebaseAuth.currentUser?.uid)
  //       .snapshots();
  // }

  @override
  Stream? get stream => FirebaseFirestore.instance
      .collection("History")
      .where("customerID", isEqualTo: _firebaseAuth.currentUser?.uid)
      .snapshots();

  // //history
  // Future<List<History>> getPetHistory() async {
  //   try {
  //     List<History> listHistory = [];

  //     QuerySnapshot qsnap = await _firebaseFirestore
  //         .collection("History")
  //         .where("customerID", isEqualTo: _firebaseAuth.currentUser?.uid)
  //         .get();
  //     //cara 1
  //     for (var element in qsnap.docs) {
  //       listHistory
  //           .add(History.fromJson(element.data() as Map<String, dynamic>));
  //     }

  //     //cara 2
  //     // listHistory = qsnap.docs.map((doc) => History.fromJson(doc.data() as Map<String,dynamic>)).toList();
  //     return listHistory;
  //   } on Failure catch (e) {
  //     throw Failure(
  //       400,
  //       message: e.toString(),
  //       location: 'FirebaseService.getPetHistory',
  //     );
  //   }
  // }

}