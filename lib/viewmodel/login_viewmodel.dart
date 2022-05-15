import 'package:vetclinic/locator.dart';
import 'package:vetclinic/services/firebase_service.dart';
import 'package:vetclinic/services/local_storage_service.dart';
import 'package:vetclinic/utils/validators.dart';
import 'package:vetclinic/viewmodel/base_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _isHidden = true;

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  // Getters
  bool get isHidden => _isHidden;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  String? Function(String? password) get passwordValidator =>
      Validator.passwordValidator;

  String? Function(String? email) get emailValidator =>
      Validator.emailValidator;

  // Setters
  set isHidden(bool val) {
    _isHidden = val;
    notifyListeners();
  }

  void onModelReady() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void onModelDestroy() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<bool> login() async {
    var res = await _firebaseService.signIn(
      _emailController.text.trim(),
      _passwordController.text,
    );
    _localStorageService.isLoggedIn = res != null;
    return res != null;
  }
}
