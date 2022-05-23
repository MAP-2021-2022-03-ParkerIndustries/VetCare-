
import 'package:map_mvvm/failure.dart';
import 'package:vetclinic/utils/error_codes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../model/users.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User get currentUser => _firebaseAuth.currentUser!;

  // Sign In with email and password
  Future<Users> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw const Failure(2,
            message: 'No user found for that email.',
            location: 'firebaseServiceFireStore.logIn() on FirebaseException');
      } else if (e.code == 'wrong-password') {
        throw const Failure(2,
            message: 'Wrong password provided for that user.',
            location: 'firebaseServiceFireStore.logIn() on FirebaseException');
      }
    }
    return readUsers();
  }

  //read user
  @override
  Future<Users> readUsers() async {
    try {
      final doc = await FirebaseFirestore.instance
          .doc('users/${currentUser.uid}')
          .get();
      final users = Users.fromJson(doc.data()!);
      return users;
    } on FirebaseException catch (e) {
      throw Failure(100,
          message: e.toString(),
          location: 'UsersServiceFireStore.readUsers() on FirebaseException');
    } catch (e) {
      throw Failure(101,
          message: e.toString(),
          location: 'UsersServiceFireStore.readUsers() on other exception');
    }
  }

  //write user
    @override
  Future<Users> writeUsers(Users users) async {
    try {
      await FirebaseFirestore.instance
          .doc('Users/$currentUser')
          .set(users.toJson());
      return users.copyWith();
    } on FirebaseException catch (e) {
      // throw Failures.cannotWrite;
      throw Failure(200,
          message: e.toString(),
          location: 'UsersServiceFireStore.writeUsers() on FirebaseException');
    } catch (e) {
      throw Failure(201,
          message: e.toString(),
          location: 'UsersServiceFireStore.writeUsers() on other exceptions');
    }
  }
  
  // Sign Up using email address
  Future<UserCredential?> signUp(
      String name, String email, String password) async {
    try {
      var _user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firebaseFirestore
          .collection('Users')
          .doc(_user.user!.uid)
          .set({
            'name': name,
          })
          .then((value) => debugPrint('User Created : ${_user.user!.email}'))
          .catchError((e) => debugPrint('Database Error!'));
      return _user;
    } on FirebaseAuthException catch (e) {
      debugPrint(
          signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!');
    } catch (e) {
      debugPrint('${e.toString()} Error Occured!');
    }
  
  }

  Future resetPass(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);

    } on FirebaseAuthException catch (e) {
      debugPrint(
          passwordResetErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!');
    } catch (e) {
      debugPrint('${e.toString()} Error Occured!');
    }
  }

  // Save Favorites
  Future saveFavorites(List<String> countries) async {
    try {
      await _firebaseFirestore.collection('Users').doc(currentUser.uid).set(
        {
          'favorites': countries,
        },
        SetOptions(merge: true),
      );
    } on FirebaseAuthException catch (e) {
      throw signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!';
    } catch (e) {
      throw '${e.toString()} Error Occured!';
    }
  }

  // Fetch Favorites
  Future<List<String>> fetchFavorites() async {
    try {
      var snapshot = await _firebaseFirestore
          .collection('Users')
          .doc(currentUser.uid)
          .get();
      return List.castFrom<dynamic, String>(
          snapshot.data()?['favorites'] ?? []);
    } on FirebaseAuthException catch (e) {
      throw signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!';
    } catch (e) {
      throw '${e.toString()} Error Occured!';
    }
  }

  // Fetch User Information
  Future<String> fetchUserInformation() async {
    try {
      var snapshot = await _firebaseFirestore
          .collection('Users')
          .doc(currentUser.uid)
          .get();
      return snapshot.data()?['name'] as String;
    } on FirebaseAuthException catch (e) {
      throw signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!';
    } catch (e) {
      throw '${e.toString()} Error Occured!';
    }
  }

  // Update user information
  Future updateUserInformation(String name) async {
    try {
      await _firebaseFirestore.collection('Users').doc(currentUser.uid).set(
        {
          'name': name,
        },
        SetOptions(merge: true),
      );
    } on FirebaseAuthException catch (e) {
      throw signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!';
    } catch (e) {
      throw '${e.toString()} Error Occured!';
    }
  }

  // Sign Out
  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    return 'Signed Out Successfully';
  }
}
