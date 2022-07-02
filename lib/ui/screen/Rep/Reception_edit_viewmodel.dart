import 'package:map_mvvm/map_mvvm.dart';


import '../../../app/service_locator.dart';
import '../../../model/Users.dart';
import '../../../services/firebase/firebase_service.dart';
import '../../../services/firebase/firebase_service_vet_booking_list.dart';

class EditBookingViewModel extends Viewmodel{
  FirebaseService get _service => locator<FirebaseService>();
  FirebaseServiceVetBooking get _vetservice => locator<FirebaseServiceVetBooking>();
  Users user = Users();

  Future<dynamic> getBooking()async {
    user= await _vetservice.readOwnerInfo(_service.getUserId());
    return user;
    
  }
}