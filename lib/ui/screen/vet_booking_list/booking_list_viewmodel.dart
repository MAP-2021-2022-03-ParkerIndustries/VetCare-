import 'dart:async';

import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/app/app.dart';
import 'package:vetclinic/model/Users.dart';
import 'package:vetclinic/model/pet.dart';
import 'package:vetclinic/services/firebase/firebase_service.dart';
import 'package:vetclinic/services/firebase/firebase_service_vet_booking_list.dart';

import '../../../model/booking.dart';

class VetBookingListVM extends Viewmodel {
  FirebaseService get _service => locator<FirebaseService>();
  FirebaseServiceVetBooking get _vetBookingService =>
      locator<FirebaseServiceVetBooking>();
  StreamSubscription? _vetBookingServiceStreamListener;
  bool get isListeningTovetBookingServiceStream =>
      _vetBookingServiceStreamListener != null;

  Users _users = Users();
  List<Booking> listBooking = [];
  List<Booking> _listBooking = [];
  List<Pet> petList = [];
  Users owner = Users();
  Users get users => _users;
  @override
  void init() async {
    super.init();
    await update(
      () async {
        try {
          _users = await _service.readUsers();
        } on Failure {
          rethrow;
        }
      },
    );
    _vetBookingServiceStreamListener = _vetBookingService.listen(
      onDone: dispose,
      onData: (_data) async {
        await update(
          () async {
            listBooking = [];
            for (var element in _data.docs) {
              listBooking.add(
                  Booking.fromJson(element.data() as Map<String, dynamic>));
            }

            // for (var i = 0; i < listBooking.length; i++) {
            //   var petID=listBooking[i].petID;
            //   listPet[i]=_vetBookingService.readPetInfo(petID) as Pet;
            _listBooking = listBooking;
            // readPetInfo();
            // }
          },
        );
      },
      onError: (e) {
        catchError(Failure(401,
            message: e.toString(),
            location:
                'BookingListVM.onData.streamListener on other exceptions'));
      },
    );
  }

  Future<Pet> readPetInfo(dynamic index) async {
    try {
      petList
          .add(await _vetBookingService.readPetInfo(_listBooking[index].petID));

      // for (var i = 0; i < pet.length; i++) {
      //   print(pet[i].petName);
      // }
      return petList.elementAt(index);
    } on Failure {
      print(Failure);
      rethrow;
    }
  }

  Future<Users> readOwnerInfo(dynamic index) async {
    owner =
        await _vetBookingService.readOwnerInfo(_listBooking[index].customerID);

    // for (var i = 0; i < pet.length; i++) {
    //   print(pet[i].petName);
    // }
    return owner;
  }

  @override
  void dispose() {
    _vetBookingServiceStreamListener?.cancel();
    _vetBookingServiceStreamListener = null;
    super.dispose();
  }
}
