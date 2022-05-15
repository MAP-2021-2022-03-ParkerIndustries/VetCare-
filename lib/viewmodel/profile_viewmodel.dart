import 'package:vetclinic/enums/view_state.dart';
import 'package:vetclinic/locator.dart';
import 'package:vetclinic/services/firebase_service.dart';
import 'package:vetclinic/services/local_storage_service.dart';
import 'package:vetclinic/viewmodel/base_viewmodel.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends BaseViewModel {
  late TextEditingController controller;
  late String email, name;

  bool _isEditing = false, _isChanged = false;
  final FirebaseService _service = locator<FirebaseService>();
  final LocalStorageService _storageService = locator<LocalStorageService>();

  bool get isEditing => _isEditing;

  bool get isChanged => _isChanged;

  set isEditing(bool val) {
    _isEditing = val;
    notifyListeners();
  }

  void cancelChanges() {
    controller.text = name;
    _isEditing = false;
    _isChanged = false;
    notifyListeners();
  }

  void onChanged() {
    _isChanged = controller.text.trim().compareTo(name) != 0;
    notifyListeners();
  }

  void update() async {
    await _service.updateUserInformation(controller.text.trim());
    name = controller.text.trim();
    _isEditing = false;
    _isChanged = false;
    notifyListeners();
  }

  void onModelReady() async {
    setState(ViewState.BUSY);
    email = _service.currentUser.email!;
    name = await _service.fetchUserInformation();
    controller = TextEditingController(text: name);
    controller.addListener(onChanged);
    setState(ViewState.IDLE);
  }

  void onModelDestroy() {
    controller.dispose();
  }

  Future<void> signout() async {
    await _service.signOut();
    _storageService.isLoggedIn = false;
  }
}