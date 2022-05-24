// import 'package:map_mvvm/viewmodel.dart';
// import 'package:vetclinic/enums/view_state.dart';
// import 'package:vetclinic/locator.dart';
// import 'package:vetclinic/services/firebase/firebase_service.dart';
// import 'package:vetclinic/services/local_storage_service.dart';
// import 'package:vetclinic/viewmodel/base_viewmodel.dart';
// import 'package:flutter/material.dart';

// import '../app/service_locator.dart';

// class ProfileViewModel extends Viewmodel {
//   late TextEditingController controller;
//   late String email, name;

//   bool _isEditing = false, _isChanged = false;
//   final FirebaseService _service = locator<FirebaseService>();
//   final LocalStorageService _storageService = locator<LocalStorageService>();

//   bool get isEditing => _isEditing;

//   bool get isChanged => _isChanged;

//   set isEditing(bool val) {
//     _isEditing = val;
//     notifyListeners();
//   }

//   void cancelChanges() {
//     controller.text = name;
//     _isEditing = false;
//     _isChanged = false;
//     notifyListeners();
//   }

//   void onChanged() {
//     _isChanged = controller.text.trim().compareTo(name) != 0;
//     notifyListeners();
//   }

//   void update() async {
//     await _service.updateUserInformation(controller.text.trim());
//     name = controller.text.trim();
//     _isEditing = false;
//     _isChanged = false;
//     notifyListeners();
//   }

//   void onModelReady() async {
//     setState(ViewState.BUSY);
//     email = _service.currentUser.email!;
//     name = await _service.fetchUserInformation();
//     controller = TextEditingController(text: name);
//     controller.addListener(onChanged);
//     setState(ViewState.IDLE);
//   }

//   void onModelDestroy() {
//     controller.dispose();
//   }

//   Future<void> signout() async {
//     await _service.signOut();
//     _storageService.isLoggedIn = false;
//   }
// }

import 'package:map_mvvm/failure.dart';
import 'package:map_mvvm/viewmodel.dart';

import '../../../../../app/service_locator.dart';
import '../../../services/firebase/firebase_service.dart';
import '../../../model/Users.dart';

class ProfileViewModel extends Viewmodel {
  FirebaseService get _service => locator<FirebaseService>();
  Users _users = Users();
  String? name,email,roles;

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;

    await update(
      () async {
        try {
          _users = await _service.readUsers();
          name = _users.name;
          email = _users.email;
          roles = _users.role;
        } on Failure {
          rethrow;
        }
      },
    );
  }

  Users get users => _users;

  Future<bool> signout() async {
    bool signedOut = false;
    try {
      await update(
        () async {
          signedOut = await _service.signOut();
        },
      );
    } on Failure {
      rethrow;
    }
    return signedOut;
  }
}
