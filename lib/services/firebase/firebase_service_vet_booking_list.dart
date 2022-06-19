import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/model/pet.dart';
import 'package:vetclinic/model/Users.dart';

class FirebaseServiceVetBooking with ServiceStream {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User get currentUser => _firebaseAuth.currentUser!;

  //get list booking for the vet
  @override
  Stream? get stream => FirebaseFirestore.instance
      .collection("Booking")
      .where("DoctorID", isEqualTo: _firebaseAuth.currentUser?.uid)
      .snapshots();

  //get pet info
  Future<Pet> readPetInfo(dynamic petID) async {
    try {
      final doc = await FirebaseFirestore.instance
          .doc('Pet/$petID')
          .get();
      final pet = Pet.fromJson(doc.data()!);
      return pet;
    } on FirebaseException catch (e) {
      throw Failure(100,
          message: e.toString(),
          location: 'PetServiceFireStore.readPet() on FirebaseException');
    } catch (e) {
      throw Failure(101,
          message: e.toString(),
          location: 'PetsServiceFireStore.readPet() on other exception');
    }
  }

  Future<Users> readOwnerInfo(dynamic userID) async {
    try {
      final doc = await FirebaseFirestore.instance
          .doc('Users/$userID')
          .get();
      final owner = Users.fromJson(doc.data()!);
      return owner;
    } on FirebaseException catch (e) {
      throw Failure(100,
          message: e.toString(),
          location: 'VetServiceFireStore.readOwnerInfo() on FirebaseException');
    } catch (e) {
      throw Failure(101,
          message: e.toString(),
          location: 'VetsServiceFireStore.readOwnerInfo() on other exception');
    }
  }

  Future<void> updateBookingStatus(dynamic bookingID, dynamic status)async{
    try {
      final doc=FirebaseFirestore.instance.doc('Booking/$bookingID');
      doc.update({
        'appointmentStatus': status
      });
    } catch (e) {
      throw Failure(101,
          message: e.toString(),
          location: 'VetsServiceFireStore.updateBookingStatus() on other exception');
    }
  }

}
