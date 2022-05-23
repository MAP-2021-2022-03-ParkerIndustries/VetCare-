import 'package:map_mvvm/service_locator.dart';
import 'package:vetclinic/services/firebase/firebase_service.dart';
import 'package:vetclinic/viewmodel/forgot_password_viewmodel.dart';
import 'package:vetclinic/viewmodel/home_viewmodel.dart';
import 'package:vetclinic/viewmodel/login_viewmodel.dart';
import 'package:vetclinic/viewmodel/profile_viewmodel.dart';
import 'package:vetclinic/viewmodel/register_viewmodel.dart';

import '../services/initializer/service_initializer.dart';
import '../services/initializer/service_initializer_firebase.dart';

final locator = ServiceLocator.locator;

Future<void> initializeServiceLocator() async {
  locator.registerLazySingleton<ServiceInitializer>(
      () => ServiceInitializerFirebase());

  final serviceInitializer = locator<ServiceInitializer>();
  await serviceInitializer.init();

  // Register Services

  locator.registerLazySingleton<FirebaseService>(() => FirebaseService());

  // Register Viewmodels
  locator.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
  locator.registerLazySingleton<RegisterViewModel>(() => RegisterViewModel());
  locator.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  // locator.registerLazySingleton<SignoutViewmodel>(() => SignoutViewmodel());
  locator.registerLazySingleton<ForgotPasswordViewModel>(() => ForgotPasswordViewModel());
  locator.registerLazySingleton<ProfileViewModel>(() => ProfileViewModel());
  // locator.registerLazySingleton<EditProfileViewmodel>(() => EditProfileViewmodel());
}
