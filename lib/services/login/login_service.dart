import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vetclinic/models/user.dart';

class FireStoreUser{

    final CollectionReference _userCollectionRef = FirebaseFirestore.instance.collection("User");
    
    UserModel _userModel= UserModel(email: email-, pass: pass, name: name);



    
}

