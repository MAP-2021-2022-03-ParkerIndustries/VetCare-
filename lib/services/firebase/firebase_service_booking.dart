
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:map_mvvm/failure.dart';
import 'package:map_mvvm/service_stream.dart';
import 'package:vetclinic/model/pet.dart';
import 'package:vetclinic/model/users.dart';

import '../../model/booking.dart';

class FirebaseServiceBooking with ServiceStream  {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  dynamic name='';
   dynamic email='';
   dynamic subject='Booking Confirmation for ';
   String emailrep='';
  //firebase cloud function for booking and users relation
  @override
  Stream? get stream => FirebaseFirestore.instance
      .collection('Users')
      .where("role", isEqualTo: "vet")
      .snapshots();


  //Booking CRUD
  @override
  Future<void> MakeBooking(Booking booking) async {
    try {
      // var book = await _firebaseFirestore.collection("Booking")
      // .doc()
      // .set(booking.toJson());

      var book= _firebaseFirestore.collection("Booking").doc();
      await book.set(
       { 'bookingID': book.id ,
       }

      );
       _firebaseFirestore.collection("Booking").doc(book.id).update(booking.toJson());
      //user
      final doc = await FirebaseFirestore.instance
          .doc('Users/${booking.customerID}')
          .get();
      final owner = Users.fromJson(doc.data()!);

      //pet
      final doc1 = await FirebaseFirestore.instance
          .doc('Pet/${booking.petID}')
          .get();
      final pet = Pet.fromJson(doc1.data()!);
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final serviceId = 'service_l05oha8';
      final templateId = 'template_l4jdbeo';
      final userId = 'sJvFcXbvm2rfgR4bP';
      email=_firebaseAuth.currentUser!.email;
     
  
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  
 
  final response = await http.post(
    url,
    headers: {
      'origin':'http://localhost',
      'Content-Type': 'application/json'

      },
    body: json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params':{
        'user_name':owner.name.toString(),
        'user_email': email.toString(),
        'user_subject':subject.toString(),
        'booking_id':book.id.toString(),
        'date':formatter.format(DateTime.fromMillisecondsSinceEpoch(booking.dateBooking)).toString(),
        'Pet_ID':pet.petName.toString(),
        'Pet_type':pet.petType.toString(),
      }
    }),

  );
 

    } on Failure catch (e) {
      throw Failure(
        400,
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> cancelBooking(Booking booking) async {
    try {
      var cbook = await _firebaseFirestore.collection("Booking").doc();
    } on Failure catch (e) {
      throw Failure(
        400,
        message: e.toString(),
      );
    }
  }
  Future<void> getBooking(Booking booking) async{
    try {
     CollectionReference _collectionRef= FirebaseFirestore.instance.collection('Booking');
     QuerySnapshot querySnapshot = await _collectionRef.get();
     
    } on Failure catch (e) {
      throw Failure(
        400,
        message: e.toString(),
      );
    }
  }
}
