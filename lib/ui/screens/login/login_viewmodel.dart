import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vetcare/viewmodel.dart';
// import 'package:vetclinic/models/user.dart';
import 'package:get_it/get_it.dart';

class LoginViewModel extends Viewmodel {
  late String email, password;

  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;

    void signInWithEmailAndPassword() async {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } on Exception catch (e) {
        String errorMessage =
            e.toString().substring(e.toString().indexOf(' ') + 1);
        SnackBar(content: Text(errorMessage));
      }
    }

    void signOut() async {
      try {
        await _auth.signOut();
      } on Exception catch (e) {
        print(e);
      }
    }
  }
}
