
import 'package:vetclinic/services/firebase_service.dart';
import 'package:vetclinic/services/local_storage_service.dart';
import 'package:vetclinic/viewmodel/forgot_password_viewmodel.dart';
import 'package:vetclinic/viewmodel/home_viewmodel.dart';
import 'package:vetclinic/viewmodel/login_viewmodel.dart';
import 'package:vetclinic/viewmodel/profile_viewmodel.dart';
import 'package:vetclinic/viewmodel/register_viewmodel.dart';
import 'package:vetclinic/viewmodel/startup_viewmodel.dart';
import 'package:get_it/get_it.dart';

import 'services/api_service.dart';

GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {
  // Services
  locator.registerSingleton<LocalStorageService>(
    await LocalStorageService.getInstance(),
  );
  locator.registerSingleton<FirebaseService>(FirebaseService());
  locator.registerSingleton<ApiService>(ApiService());

  // Viewmodel
  locator.registerFactory<StartUpViewModel>(() => StartUpViewModel());
  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<RegisterViewModel>(() => RegisterViewModel());
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  locator.registerFactory<ProfileViewModel>(() => ProfileViewModel());
  locator.registerFactory<ForgotPasswordViewModel>(() => ForgotPasswordViewModel());
}
