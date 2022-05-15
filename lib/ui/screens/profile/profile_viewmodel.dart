import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vetcare/viewmodel.dart';

class ProfileVM extends Viewmodel{
  
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> fetchUserData() async{
    

  }

}