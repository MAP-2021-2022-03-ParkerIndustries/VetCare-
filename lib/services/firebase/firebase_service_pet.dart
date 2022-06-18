import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_mvvm/map_mvvm.dart';

class FirebaseServicePet with ServiceStream {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream? get stream => FirebaseFirestore.instance
      .doc('Pet')
      .snapshots();
}
