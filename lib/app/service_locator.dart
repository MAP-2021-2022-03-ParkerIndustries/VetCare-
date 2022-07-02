import 'package:map_mvvm/service_locator.dart';
import 'package:vetclinic/services/firebase/firebase_service.dart';
import 'package:vetclinic/services/firebase/firebase_service_booking_history.dart';
import 'package:vetclinic/services/firebase/firebase_service_firestore.dart';
import 'package:vetclinic/services/firebase/firebase_service_pet.dart';
import 'package:vetclinic/services/firebase/firebase_service_vet_booking_list.dart';
import 'package:vetclinic/ui/screen/Receptionist_home/Receptionist_home_viewmodel.dart';
import 'package:vetclinic/ui/screen/Rep/Receptionist_edit_view.dart';
import 'package:vetclinic/ui/screen/forgot_password/forgot_password_viewmodel.dart';
import 'package:vetclinic/ui/screen/history/history_viewmodel.dart';
import 'package:vetclinic/ui/screen/pet_medical_record/pet_medical_record_viewmodel.dart';
import 'package:vetclinic/ui/screen/register_pet/register_pet_viewmodel.dart';
import 'package:vetclinic/ui/screen/vet_booking_list/booking_list_viewmodel.dart';
import 'package:vetclinic/ui/screen/vet_home/vet_home_viewmodel.dart';
import 'package:vetclinic/ui/screen/login/login_viewmodel.dart';
import 'package:vetclinic/ui/screen/profile/profile_viewmodel.dart';
import 'package:vetclinic/ui/screen/register/register_viewmodel.dart';
import 'package:vetclinic/ui/screen/view_pet/petList_view_Model.dart';

import '../services/firebase/firebase_service_booking.dart';
import '../services/firebase/firebase_service_history.dart';
import '../services/firebase/firebase_service_profile.dart';
import '../services/firebase/firebase_service_register_pet.dart';
import '../services/initializer/service_initializer.dart';
import '../services/initializer/service_initializer_firebase.dart';
import '../ui/screen/Rep/Reception_edit_viewmodel.dart';
import '../ui/screen/booking/booking_viewmodel.dart';
import '../ui/screen/customer_home/customer_home_viewmodel.dart';
import '../ui/screen/vet_update_booking/update_booking_detail_viewmodel.dart';

final locator = ServiceLocator.locator;

Future<void> initializeServiceLocator() async {
  locator.registerLazySingleton<ServiceInitializer>(() => ServiceInitializerFirebase());

  final serviceInitializer = locator<ServiceInitializer>();
  await serviceInitializer.init();

  // Register Services
  locator.registerLazySingleton<FirebaseService>(() => FirebaseServiceFirestore()); //original
  locator.registerLazySingleton<FirebaseServiceHistory>(() =>FirebaseServiceHistory());
  locator.registerLazySingleton<FirebaseServiceRegisterPet>(() =>FirebaseServiceRegisterPet());
  locator.registerLazySingleton<FirebaseServiceProfile>(() =>FirebaseServiceProfile());
  locator.registerLazySingleton<FirebaseServiceBooking>(() =>FirebaseServiceBooking());
  locator.registerLazySingleton<FirebaseServiceVetBooking>(() =>FirebaseServiceVetBooking());
  locator.registerLazySingleton<FirebaseServicePet>(() =>FirebaseServicePet());
  locator.registerLazySingleton<FirebaseServiceBookingHistory>(() =>FirebaseServiceBookingHistory());

  //Register Models
 
  locator.registerLazySingleton<CustomerHomeViewModel>(() => CustomerHomeViewModel());
  locator.registerLazySingleton<VetHomeViewModel>(() => VetHomeViewModel());
  locator.registerLazySingleton<RegisterViewModel>(() => RegisterViewModel());
  locator.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  locator.registerLazySingleton<ForgotPasswordViewModel>(() => ForgotPasswordViewModel());
  locator.registerLazySingleton<ProfileViewModel>(() => ProfileViewModel());
  locator.registerLazySingleton<HistoryViewModel>(() => HistoryViewModel());
  locator.registerLazySingleton<RegisterPetVM>(() => RegisterPetVM());
  locator.registerLazySingleton<VetBookingListVM>(() => VetBookingListVM());
  locator.registerLazySingleton<BookingViewModel>(() => BookingViewModel());
  locator.registerLazySingleton<ReceptionistHomeViewModel>(() => ReceptionistHomeViewModel());
  locator.registerLazySingleton<EditBookingViewModel>(() => EditBookingViewModel());
  locator.registerLazySingleton<UpdateBookingDetailVM>(() => UpdateBookingDetailVM());
  locator.registerLazySingleton<PetListVM>(() => PetListVM());
  locator.registerLazySingleton<PetMedicalRecordVM>(() => PetMedicalRecordVM());

}
