import 'package:map_mvvm/viewmodel.dart';


class VetHomeViewModel extends Viewmodel {
  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;

    await update(() async {
      try {} catch (e) {}
    });
  }
}
