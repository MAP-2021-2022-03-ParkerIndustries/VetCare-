import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/services/firebase/firebase_service_vet_booking_list.dart';

import '../../../app/service_locator.dart';
import '../../../services/firebase/firebase_service.dart';

class ReceptionistHomeViewModel extends Viewmodel{
  FirebaseService get _service => locator<FirebaseService>();
  FirebaseServiceVetBooking get _vetservice => locator<FirebaseServiceVetBooking>();
  
}