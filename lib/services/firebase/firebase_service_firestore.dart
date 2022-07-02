import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/model/receptionist.dart';
import 'package:vetclinic/model/vet.dart';

import '../../model/Users.dart';
import '../../model/pet.dart';
import '../../utils/error_codes.dart';
import 'firebase_service.dart';

class FirebaseServiceFirestore extends FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User get currentUser => _firebaseAuth.currentUser!;

  // Sign In with email and password
  @override
  Future<Users> signIn(email, password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
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

  // Sign Out
  @override
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } on Failure catch (e) {
      throw Failure(300,
          message: e.toString(),
          location: 'FirebaseService.signOut() on other exceptions');
    }
  }

  //read user
  @override
  Future<Users> readUsers() async {
    try {
      final doc = await FirebaseFirestore.instance
          .doc('Users/${currentUser.uid}')
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
  @override
  Future<void> signUp(name, email, password) async {
    try {
      var _user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firebaseFirestore.collection('Users').doc(_user.user!.uid).set({
        'name': name,
        'email': _user.user!.email,
        'role': 'customer',
        'profileImg':'https://firebasestorage.googleapis.com/v0/b/vetcare-4e23b.appspot.com/o/profilePic.png?alt=media&token=f245930b-0adf-4797-8640-e3d05254c03d',
        'userID' : _user.user!.uid,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw const Failure(1,
            message: 'The password provided is too weak',
            location: 'firebaseServiceFireStore.signUp() on FirebaseException');
      } else if (e.code == 'email-already-in-use') {
        throw const Failure(1,
            message: 'The account already exists for that email.',
            location: 'firebaseServiceFireStore.signUp() on FirebaseException');
      }
    } catch (e) {
      throw const Failure(1,
          message: 'Not Firebase error but other error.',
          location: 'firebaseServiceFireStore.signUp() on FirebaseException');
    }
  }

  @override
  Future<void> resetPass(email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e) {
      throw const Failure(100,
          message: 'username not found',
          location: 'UsersServiceFireStore.readUsers() on FirebaseException');
    }
  }

  // Update user information
  @override
  Future updateUserInformation(String name,dynamic profileImg) async {
    try {
      await _firebaseFirestore.collection('Users').doc(currentUser.uid).set(
        {
          'name': name,
          'profileImg':profileImg
          
        },
        SetOptions(merge: true),
      );
    } on FirebaseAuthException catch (e) {
      throw signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!';
    } catch (e) {
      throw '${e.toString()} Error Occured!';
    }
  }


  //Vet Crud
  @override
  Future<void> registerVet(Vet doctor) async {
    try {
          await _firebaseFirestore.collection("Vet").doc().set(doctor.toJson());
    } on Failure catch (e) {
      throw Failure(400, message: e.toString());
    }
  }

@override
Future<void> registerReception(Receptionist recep)async{
  try {
          await _firebaseFirestore.collection("Receptionist").doc().set(recep.toJson());
    } on Failure catch (e) {
      throw Failure(400, message: e.toString());
    }

}



  //register a pet
  @override


  //get user id
  @override
  Future<dynamic> getUserId() async {
    return _firebaseAuth.currentUser?.uid;
  }

  
  // @override
  



 @override
  Future<Pet> getPet() async{
    try {
      final doc = await FirebaseFirestore.instance
          .doc('Users/${currentUser.uid}')
          .get();
      final pet = Pet.fromJson(doc.data()!);
      return pet;
    } on FirebaseException catch (e) {
      throw Failure(100,
          message: e.toString(),
          location: 'UsersServiceFireStore.readPet() on FirebaseException');
    } catch (e) {
      throw Failure(101,
          message: e.toString(),
          location: 'UsersServiceFireStore.readPet() on other exception');
    }

  }

}
