// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:map_mvvm/service_stream.dart';

import '../../model/Users.dart';
import '../../model/booking.dart';
import '../../model/history.dart';
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
  Future updateUserInformation(String name);

  //Booking
  Future<void> MakeBooking(Booking booking);


  //history
  Future<List<History>> getPetHistory();
  Future<void> registerPet(Pet pet);
  Future<String?>getUserId();
  Stream? snapHistory();

  //Firebase storage
  Future<void> uploadProfileImage();
  Future<void> uploadPetImage();
}
