import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_mvvm/map_mvvm.dart';

class FirebaseServicePet with ServiceStream {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream? get stream => FirebaseFirestore.instance
      .collection('Pet')
      .where("petOwner", isEqualTo: _firebaseAuth.currentUser?.uid)
      .snapshots();


  Future deletePet(dynamic petID)async{
    _firebaseFirestore.collection('Pet').doc(petID).delete();
  }
}
