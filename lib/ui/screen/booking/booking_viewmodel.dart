import 'package:map_mvvm/viewmodel.dart';
import 'package:vetclinic/services/firebase/firebase_service.dart';
import 'package:vetclinic/app/service_locator.dart';
import 'package:vetclinic/model/users.dart';
import 'package:vetclinic/model/booking.dart';
import 'package:vetclinic/services/firebase/firebase_service_booking.dart';


class BookingViewModel extends Viewmodel {
  FirebaseService get _service => locator <FirebaseService>();
  Users _users = Users();
 FirebaseServiceBooking get _serviceBooking => locator <FirebaseServiceBooking>();


}