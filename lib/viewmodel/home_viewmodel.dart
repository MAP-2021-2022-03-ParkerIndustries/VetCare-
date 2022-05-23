import 'package:map_mvvm/viewmodel.dart';


class HomeViewModel extends Viewmodel {
  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;

    await update(() async {
      try {} catch (e) {}
    });
  }
}
