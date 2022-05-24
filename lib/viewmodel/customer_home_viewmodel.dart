import 'package:map_mvvm/viewmodel.dart';


class CustomerHomeViewModel extends Viewmodel {
  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;

    await update(() async {
      try {} catch (e) {}
    });
  }
}
