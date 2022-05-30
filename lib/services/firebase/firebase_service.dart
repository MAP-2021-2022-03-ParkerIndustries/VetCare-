// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_mvvm/service_stream.dart';
import 'package:vetclinic/model/history.dart';

import '../../model/Users.dart';
import '../../model/pet.dart';

abstract class FirebaseService with ServiceStream {
  //authentication
  Future<void> signUp(name,email,password);
  Future<Users> signIn(email,password);
  Future<void> resetPass(email);
  Future<bool> signOut();

  //users
  Future<Users> readUsers();
  Future<Users> writeUsers(Users users);

  //history
  Future<List<History>> getPetHistory();
  Future<void> registerPet(Pet pet);
  Future<String?>getUserId();
}
