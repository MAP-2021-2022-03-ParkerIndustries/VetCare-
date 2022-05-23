import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/services/firebase/firebase_service.dart';

import '../app/app.dart';

class ForgotPasswordViewModel extends Viewmodel {
  FirebaseService get _service => locator<FirebaseService>();
  String email = '';

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  Future<void> reset(email) async {
    try {
      await update(() async {
        await _service.resetPass(email);
      });
    } on Failure {
      rethrow;
    }
  }
}
