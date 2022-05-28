import 'dart:async';

import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/app/service_locator.dart';
import 'package:vetclinic/model/Users.dart';
import 'package:vetclinic/model/history.dart';
import 'package:vetclinic/services/firebase/firebase_service.dart';

class HistoryViewModel extends Viewmodel {
  FirebaseService get _service => locator<FirebaseService>();
  Users _users = Users();
  StreamSubscription? _historyServiceStreamListener;
  bool get isListeningToHistoryServiceStream =>
      _historyServiceStreamListener != null;

  Users get users => _users;
  List<History> listHistory = [];

  @override
  void init() async {
    super.init();
    // notifyListenersOnFailure = false;
    await update(
      () async {
        try {
          _users = await _service.readUsers();
          getHistory();
        } on Failure {
          rethrow;
        }
      },
    );

    _historyServiceStreamListener = _service.listen(
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

  Future<List<History>> getHistory() async {
    try {
      await update(
        () async {
          listHistory = await _service.getPetHistory();
        },
      );
      return listHistory;
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
