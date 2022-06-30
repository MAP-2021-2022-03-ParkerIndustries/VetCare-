import 'dart:async';
import 'dart:io';

import 'package:map_mvvm/map_mvvm.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../app/service_locator.dart';
import '../../../model/Users.dart';
import '../../../model/pet.dart';
import '../../../services/firebase/firebase_service.dart';
import '../../../services/firebase/firebase_service_pet.dart';

class PetListVM extends Viewmodel{
   FirebaseService get _service => locator<FirebaseService>();
  FirebaseServicePet get _servicePet => locator<FirebaseServicePet>();
  
  Users _users = Users();

  StreamSubscription? _petServiceStreamListener;
  bool get isListeningToPetServiceStream =>  _petServiceStreamListener != null;

  Users get users => _users;
  List<Pet> listPet = [];

  @override
  void init() async {
    super.init();
    await update(
      () async {
        try {
          _users = await _service.readUsers();
        } on Failure {
          rethrow;
        }
      },
    );
    _petServiceStreamListener = _servicePet.listen(
      onDone: dispose,
      onData: ( _data) async {
        await update(
        () async {
         //reset listPet
          listPet = [];
           //transform querysnapshot => List<Pet>
          for (var element in _data.docs) {
            listPet
                .add(Pet.fromJson(element.data() as Map<String, dynamic>));
          }
        },
      );
      },
      onError: (e) {
        catchError(Failure(401,
            message: e.toString(),
            location:
                'PetViewmodel.onData.streamListener on other exceptions'));
      },
    );
    
  }

  Future<void> createPDF(index) async{
    PdfDocument document=PdfDocument();
    document.pages.add();

    List<int> bytes =document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'Medical Report.pdf');
  }

  Future<void> saveAndLaunchFile(List<int> bytes,String fileName) async {
    final path=(await getExternalStorageDirectory())?.path;
    final file=File('$path/$fileName');
    await file.writeAsBytes(bytes,flush: true);
    OpenFile.open('$path/$fileName');
  }

  Future<void>deletePet(dynamic petID)async{
    _servicePet.deletePet(petID) ;
  }
}