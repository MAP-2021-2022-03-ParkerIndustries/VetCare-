import 'dart:async';

import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/app/service_locator.dart';
import 'package:vetclinic/model/Users.dart';
import 'package:vetclinic/model/history.dart';
import 'package:vetclinic/services/firebase/firebase_service.dart';

import '../../../services/firebase/firebase_service_history.dart';

class HistoryViewModel extends Viewmodel {
  FirebaseService get _service => locator<FirebaseService>();
  FirebaseServiceHistory get _serviceHistory => locator<FirebaseServiceHistory>();
  
  Users _users = Users();

  StreamSubscription? _historyServiceStreamListener;
  bool get isListeningToHistoryServiceStream =>  _historyServiceStreamListener != null;

  Users get users => _users;
  List<History> listHistory = [];

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
      onData: ( _data) async {
        await update(
        () async {
         //reset listhistory
          listHistory = [];
           //transform querysnapshot => List<History>
          for (var element in _data.docs) {
            listHistory
                .add(History.fromJson(element.data() as Map<String, dynamic>));
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

  @override
  void dispose() {
    _historyServiceStreamListener?.cancel();
    _historyServiceStreamListener = null;
    super.dispose();
  }
}
