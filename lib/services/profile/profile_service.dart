import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vetclinic/models/user.dart';

class FireStoreUser {
  late String? user = FirebaseAuth.instance.currentUser?.uid;
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Users');

  Future<DocumentSnapshot> getUserFromFirestore() async {
    return await _userCollectionRef
        .doc(user).get();
  }
  
}
