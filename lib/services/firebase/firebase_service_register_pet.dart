import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/model/pet.dart';

class FirebaseServiceRegisterPet {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User get currentUser => _firebaseAuth.currentUser!;

  Future<String> uploadPetImage(String filePath, String fileName) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    File file = File(filePath);
    final userId = _firebaseAuth.currentUser?.uid;

    try {
      await storage.ref('users/$userId/pet/$fileName').putFile(file);
      final imageUrl = await storage
          .ref()
          .child('users/$userId/pet/$fileName')
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

  Future <void> registerPet(Pet pet) async {
    try {
      var petCollection = await _firebaseFirestore.collection('Pet').doc();

      petCollection.set(pet.toJson());
    } on Failure catch (e) {
      throw Failure(
        400,
        message: e.toString(),
      );
    }
  }
}
