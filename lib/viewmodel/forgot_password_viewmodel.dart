import 'package:vetclinic/locator.dart';
import 'package:vetclinic/services/firebase_service.dart';
import 'package:vetclinic/services/local_storage_service.dart';
import 'package:vetclinic/utils/validators.dart';
import 'package:vetclinic/viewmodel/base_viewmodel.dart';

import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  late final TextEditingController _emailController;
  bool _isHidden = true;

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  // Getters
  bool get isHidden => _isHidden;

  TextEditingController get emailController => _emailController;

  String? Function(String? name) get nameValidator => Validator.nameValidator;

  String? Function(String? email) get emailValidator =>
      Validator.emailValidator;

  String? Function(String? password) get passwordValidator =>
      Validator.passwordValidator;

  // Setters
  set isHidden(bool val) {
    _isHidden = val;
    notifyListeners();
  }

  void onModelReady() {
    _emailController = TextEditingController();
  }

  void onModelDestroy() {
    _emailController.dispose();
  }

  Future<bool> reset() async {
    return await _firebaseService.resetPass(
      _emailController.text.trim(),
    );
  
  }
}
