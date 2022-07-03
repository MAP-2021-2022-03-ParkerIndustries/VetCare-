import 'dart:async';

import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/app/service_locator.dart';
import 'package:vetclinic/model/Users.dart';
import 'package:vetclinic/model/booking.dart';
import 'package:vetclinic/services/firebase/firebase_service.dart';
import 'package:vetclinic/services/firebase/firebase_service_booking_history.dart';

import '../../../model/pet.dart';
import '../../../services/firebase/firebase_service_pet.dart';

class HistoryViewModel extends Viewmodel {
  FirebaseService get _service => locator<FirebaseService>();
  FirebaseServiceBookingHistory get _serviceHistory =>
      locator<FirebaseServiceBookingHistory>();
  FirebaseServicePet get _servicePet => locator<FirebaseServicePet>();

  Users _users = Users();

  StreamSubscription? _petServiceStreamListener;
  StreamSubscription? _historyServiceStreamListener;
  bool get isListeningToHistoryServiceStream =>
      _historyServiceStreamListener != null;
  bool get isListeningToPetServiceStream => _petServiceStreamListener != null;

  Users get users => _users;
  List<Booking> listHistory = [];
  List<Pet> listPet = [];

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
    _historyServiceStreamListener = _serviceHistory.listen(
      onDone: dispose,
      onData: (_data) async {
        await update(
          () async {
            //reset listhistory
            listHistory = [];
            //transform querysnapshot => List<History>
            for (var element in _data.docs) {
              listHistory.add(
                  Booking.fromJson(element.data() as Map<String, dynamic>));
            }
          },
        );
      },
      onError: (e) {
        catchError(Failure(401,
            message: e.toString(),
            location:
                'HistoryViewmodel.onData.streamListener on other exceptions'));
      },
    );
  }

  Future<void> updateRate(dynamic bookingID, dynamic rating) async {
    try {
      await _serviceHistory.updateRating(bookingID, rating);
    } on Failure {
      rethrow;
    }
  }


  @override
  void dispose() {
    _historyServiceStreamListener?.cancel();
    _historyServiceStreamListener = null;
    super.dispose();
  }
}
