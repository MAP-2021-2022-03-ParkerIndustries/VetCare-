import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/app/service_locator.dart';
import 'package:vetclinic/model/pet.dart';
import 'package:vetclinic/services/firebase/firebase_service.dart';
import 'package:path/path.dart' as path;
import 'package:vetclinic/services/firebase/firebase_service_register_pet.dart';

class RegisterPetVM extends Viewmodel {
  FirebaseService get _service => locator<FirebaseService>();
  FirebaseServiceRegisterPet get _petservice => locator<FirebaseServiceRegisterPet>();
  String petType = '';
  String? petOwner;
  String petName = '';
final picker = ImagePicker();
  final Pet _pet = Pet();
  String petImageURL='';
  @override
  void init() async {
    super.init();
    petOwner = await _service.getUserId();
    notifyListenersOnFailure = false;
  }

  Future<void> registerPet(petType, petName) async {
    try {
      // _pet.copyWith(
      //     petType: petType,
      //     petOwner: petOwner,
      //     petName: petName,
      //   );
      //   _pet.petName=petType;

      _pet.setPet(petType, petOwner, petName,petImageURL);
      await update(() async {
        await _petservice.registerPet(_pet);
      });
    } on Failure {
      rethrow;
    }
  }

  Future<void>uploadPetImage(String filePath, String fileName) async {
    petImageURL=await _petservice.uploadPetImage(filePath, fileName);
  }
  // Future<void> selectFile() async {
  //   final ImagePicker picker = ImagePicker();
  //  final storage=FirebaseStorage.instance;
  //   XFile? pickedImage;
  //   try {
  //     pickedImage = await picker.pickImage(
  //         source: ImageSource.gallery,
  //         // source: inputSource == 'camera' ? ImageSource.camera : ImageSource.gallery,
  //         maxWidth: 1920);

  //     final String fileName = path.basename(pickedImage!.path);
  //     File imageFile = File(pickedImage.path);

  //     try {
  //       await storage.ref(fileName).putFile(imageFile);

  //       // return storage.ref(fileName).getDownloadURL();
  //     } on FirebaseException catch (e) {
  //       throw Failure(100,
  //           message: e.toString(),
  //           location: 'UsersServiceFireStore.readUsers() on FirebaseException');
  //     }
  //   } catch (e) {
  //     throw Failure(101,
  //         message: e.toString(),
  //         location: 'UsersServiceFireStore.readUsers() on other exception');
  //   }
  // }

    
}
