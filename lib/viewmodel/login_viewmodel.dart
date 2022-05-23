import 'package:map_mvvm/failure.dart';
import 'package:map_mvvm/viewmodel.dart';

import '../../../app/service_locator.dart';
import '../../../services/firebase/firebase_service.dart';
import '../model/users.dart';

class LoginViewModel extends Viewmodel {
  FirebaseService get _service => locator<FirebaseService>();
  Users _users = Users();

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  Users get users => _users;

  Future<void> login(email, password) async {
    try {
      await update(
        () async {
          _users = await _service.signIn(email, password);
        },
      );
    } on Failure {
      rethrow;
    }
  }
}
