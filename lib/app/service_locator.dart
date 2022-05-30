import 'package:map_mvvm/service_locator.dart';
import 'package:vetclinic/services/firebase/firebase_service.dart';
import 'package:vetclinic/services/firebase/firebase_service_firestore.dart';
import 'package:vetclinic/ui/screen/forgot_password/forgot_password_viewmodel.dart';
import 'package:vetclinic/ui/screen/history/history_viewmodel.dart';
import 'package:vetclinic/ui/screen/register_pet/register_pet_viewmodel.dart';
import 'package:vetclinic/ui/screen/vet_home/vet_home_viewmodel.dart';
import 'package:vetclinic/ui/screen/login/login_viewmodel.dart';
import 'package:vetclinic/ui/screen/profile/profile_viewmodel.dart';
import 'package:vetclinic/ui/screen/register/register_viewmodel.dart';

import '../services/initializer/service_initializer.dart';
import '../services/initializer/service_initializer_firebase.dart';
import '../ui/screen/customer_home/customer_home_viewmodel.dart';

final locator = ServiceLocator.locator;

Future<void> initializeServiceLocator() async {
  locator.registerLazySingleton<ServiceInitializer>(
      () => ServiceInitializerFirebase());

  final serviceInitializer = locator<ServiceInitializer>();
  await serviceInitializer.init();

  // Register Services

  locator.registerLazySingleton<FirebaseService>(() => FirebaseServiceFirestore());
  locator.registerLazySingleton<CustomerHomeViewModel>(() => CustomerHomeViewModel());
  locator.registerLazySingleton<VetHomeViewModel>(() => VetHomeViewModel());
  locator.registerLazySingleton<RegisterViewModel>(() => RegisterViewModel());
  locator.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  // locator.registerLazySingleton<SignoutViewmodel>(() => SignoutViewmodel());
  locator.registerLazySingleton<ForgotPasswordViewModel>(() => ForgotPasswordViewModel());
  locator.registerLazySingleton<ProfileViewModel>(() => ProfileViewModel());
  // locator.registerLazySingleton<EditProfileViewmodel>(() => EditProfileViewmodel());
  locator.registerLazySingleton<HistoryViewModel>(() => HistoryViewModel());
  locator.registerLazySingleton<RegisterPetVM>(() => RegisterPetVM());
}
