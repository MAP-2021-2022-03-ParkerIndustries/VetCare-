import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/app/service_locator.dart';
import 'package:vetclinic/model/pet.dart';
import 'package:vetclinic/services/firebase/firebase_service.dart';

class RegisterPetVM extends Viewmodel{
  FirebaseService get _service => locator<FirebaseService>();
  String petType='';
  String? petOwner;
  String petName='';

   final Pet _pet=Pet();

  @override
  void init() async {
    super.init();
    petOwner= await _service.getUserId();
    notifyListenersOnFailure = false;
    
  }

  Future<void> registerPet(petType,petName) async{
    try {
      // _pet.copyWith(
      //     petType: petType,
      //     petOwner: petOwner,
      //     petName: petName,
      //   );
      //   _pet.petName=petType;

        _pet.setPet(petType, petOwner, petName);
      await update(()async{
        await _service.registerPet(_pet);
      }
      );
    } on Failure {
      rethrow;
    }
  }



}