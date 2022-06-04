import 'package:flutter/cupertino.dart';
import 'package:map_mvvm/failure.dart';
import 'package:map_mvvm/viewmodel.dart';

import '../../../../../app/service_locator.dart';
import '../../../services/firebase/firebase_service.dart';
import '../../../model/Users.dart';

class ProfileViewModel extends Viewmodel {
  FirebaseService get _service => locator<FirebaseService>();
  Users _users = Users();
  String? _name, _email, _roles;
  late TextEditingController nameController;
  bool _isEditing = false, _isChanged = false;

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;

    await update(
      () async {
        try {
          _users = await _service.readUsers();
          nameController = TextEditingController(text: _users.name);
        } catch (e) {}
      },
    );
  }

  Future<void> updateUser() async {
    await update(
      () async {
        try {
          _name = nameController.text;
          _email = _users.email;
          _roles = _users.role;
          _service.updateUserInformation(name);
        } on Failure {
          rethrow;
        }
      },
    );
  }

  Users get users => _users;
  get name => _name;
  get email => _email;
  get roles => _roles;
  set name(input) => _name;

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

  void onChanged() {
    _isChanged = nameController.text.trim().compareTo(name) != 0;
    notifyListeners();
  }

  Future<void> updateOnLoad() async {
    await update(
      () async {
        try {
          _users = await _service.readUsers();
          nameController.text = _users.name;
          notifyListeners();
        } catch (e) {}
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
