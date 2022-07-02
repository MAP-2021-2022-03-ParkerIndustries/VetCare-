import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/app/service_locator.dart';

import '../../../model/Users.dart';
import '../../../services/firebase/firebase_service.dart';
import '../../../services/firebase/firebase_service_profile.dart';

import 'dart:io';

class PetMedicalRecordVM extends Viewmodel {
  FirebaseService get _service => locator<FirebaseService>();
  FirebaseServiceProfile get _profileservice =>
      locator<FirebaseServiceProfile>();
  Users _users = Users();

  @override
  void init() async {
    super.init();
  }
}
