import 'package:vetclinic/locator.dart';
import 'package:vetclinic/services/local_storage_service.dart';
import 'package:vetclinic/viewmodel/base_viewmodel.dart';

class StartUpViewModel extends BaseViewModel {
  final LocalStorageService localStorageService =
      locator<LocalStorageService>();

  Future<bool> onModelReady() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return localStorageService.isLoggedIn;
    });
  }
}
