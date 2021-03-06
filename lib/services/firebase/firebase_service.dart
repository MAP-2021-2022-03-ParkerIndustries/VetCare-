// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:async';

import 'package:map_mvvm/service_stream.dart';

import '../../model/Users.dart';
import '../../model/booking.dart';

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
  Future updateUserInformation(String name, dynamic profileImg);

  //Booking
  // Future<void> MakeBooking(Booking booking);


  //history
  // Future<List<History>> getPetHistory();
    //pet
 
  Future<dynamic>getUserId();
  
  // Stream? snapHistory();


 
}
