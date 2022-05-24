import 'package:map_mvvm/failure.dart';
import 'package:map_mvvm/viewmodel.dart';

import '../../../app/service_locator.dart';
import '../services/firebase/firebase_service.dart';
import '../model/Users.dart';

class LoginViewModel extends Viewmodel {
  FirebaseService get _service => locator<FirebaseService>();
  Users _users = Users();

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;

    await update(() async {
      try {
        _users = await _service.readUsers();
        print(_users.name);
      } catch (e) {}
    });
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
