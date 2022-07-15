// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:map_mvvm/viewmodel.dart';
import 'package:vetclinic/app/app.dart';
import 'package:vetclinic/services/firebase/firebase_service_rating.dart';

class VetHomeViewModel extends Viewmodel {
  FirebaseServiceRating get _service => locator<FirebaseServiceRating>();
  double rating5 = 0.0;
  double rating4 = 0.0;
  double rating3 = 0.0;
  double rating2 = 0.0;
  double rating1 = 0.0;

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;

    await update(() async {
      try {
        rating5 = await _service.get_5_Rating();
        rating4 = await _service.get_4_Rating();
        rating3 = await _service.get_3_Rating();
        rating2 = await _service.get_2_Rating();
        rating1 = await _service.get_1_Rating();
      } catch (e) {}
    });
  }

  double Rating5() {
    return rating5;
  }
  double Rating4() {
    return rating4;
  }
  double Rating3() {
    return rating3;
  }
  double Rating2() {
    return rating2;
  }
    double Rating1() {
    return rating1;
  }

}
