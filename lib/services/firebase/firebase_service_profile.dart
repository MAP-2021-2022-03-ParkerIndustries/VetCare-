import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/model/Users.dart';
import 'package:vetclinic/utils/error_codes.dart';

class FirebaseServiceProfile {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User get currentUser => _firebaseAuth.currentUser!;
   
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

  Future<String> uploadProfileImage(String filePath, String fileName) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    File file = File(filePath);
    final userId = _firebaseAuth.currentUser?.uid;

    try {
      await storage.ref('users/$userId/profilePic/').putFile(file);
      final imageUrl = await storage
          .ref()
          .child('users/$userId/profilePic/')
          .getDownloadURL();
      return imageUrl;
    } on FirebaseException catch (e) {
      print(e);
      throw Failure(
        400,
        message: e.toString(),
      );
    }
  }

  // Future<String> deleteProfileImage() async {
  // final FirebaseStorage storage = FirebaseStorage.instance;
   
  //   final userId = _firebaseAuth.currentUser?.uid;

  //   try {
  //     final desertRef = storage.ref().child('users/$userId/profilePic');
  //     await desertRef.delete();
  //     var profileImg=   'https://firebasestorage.googleapis.com/v0/b/vetcare-4e23b.appspot.com/o/profilePic.png?alt=media&token=f245930b-0adf-4797-8640-e3d05254c03d';
  //     return profileImg;
  //   } on FirebaseException catch(e) {
  //     print(e);
  //     throw Failure(
  //       400,
  //       message: e.toString(),
  //     );
  //   }
  // }


}