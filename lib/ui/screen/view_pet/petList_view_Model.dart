import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:vetclinic/model/booking.dart';
import 'package:vetclinic/services/firebase/firebase_service_booking.dart';
import 'package:vetclinic/services/firebase/firebase_service_booking_history.dart';

import '../../../app/service_locator.dart';
import '../../../model/Users.dart';
import '../../../model/pet.dart';
import '../../../services/firebase/firebase_service.dart';
import '../../../services/firebase/firebase_service_pet.dart';

class PetListVM extends Viewmodel {
  FirebaseService get _service => locator<FirebaseService>();
  FirebaseServicePet get _servicePet => locator<FirebaseServicePet>();
  FirebaseServiceBookingHistory get _serviceBookingHistory =>
      locator<FirebaseServiceBookingHistory>();
  FirebaseServiceBooking get _serviceBooking =>
      locator<FirebaseServiceBooking>();
  Users _users = Users();

  StreamSubscription? _petServiceStreamListener;
  StreamSubscription? _bookingHistoryServiceStreamListener;
  StreamSubscription? _vetListServiceStreamListener;
  bool get isListeningToPetServiceStream => _petServiceStreamListener != null;
  bool get isListeningToBookingServiceStream =>
      _bookingHistoryServiceStreamListener != null;
  bool get isListeningToVetListServiceStream =>
      _vetListServiceStreamListener != null;

  Users get users => _users;
  List<Pet> listPet = [];
  List<Users> listVet = [];
  List<Booking> bookingList = [];
  String text = '';
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
    _bookingHistoryServiceStreamListener = _serviceBookingHistory.listen(
      onDone: dispose,
      onData: (_data) async {
        await update(() async {
          for (var element in _data.docs) {
            bookingList
                .add(Booking.fromJson(element.data() as Map<String, dynamic>));
          }
        });
      },
      onError: (e) {
        catchError(Failure(401,
            message: e.toString(),
            location:
                'BookingHistory.onData.streamListener on other exceptions'));
      },
    );

    _petServiceStreamListener = _servicePet.listen(
      onDone: dispose,
      onData: (_data) async {
        await update(
          () async {
            //reset listPet
            listPet = [];
            //transform querysnapshot => List<Pet>
            for (var element in _data.docs) {
              listPet.add(Pet.fromJson(element.data() as Map<String, dynamic>));
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

    _vetListServiceStreamListener = _serviceBooking.listen(
      onDone: dispose,
      onData: (_data) async {
        await update(
          () async {
            //reset listVet
            listVet = [];
            //transform querysnapshot => List<Vet>
            for (var element in _data.docs) {
              listVet
                  .add(Users.fromJson(element.data() as Map<String, dynamic>));
            }
          },
        );
      },
      onError: (e) {
        catchError(Failure(401,
            message: e.toString(),
            location:
                'BookingViewmodel.onData.streamListener on other exceptions'));
      },
    );
  }

  Future<void> createPDF(index) async {
    PdfDocument document = PdfDocument();
    PdfPage page = document.pages.add();

    //Front Page
    page.graphics.drawString(
        "MEDICAL\nREPORT\n" + listPet[index].petName.toUpperCase(),
        PdfStandardFont(PdfFontFamily.timesRoman, 50));
    var petImage = await get(Uri.parse(listPet[index].petImageURL));
    page.graphics.drawImage(
        PdfBitmap(petImage.bodyBytes), Rect.fromLTWH(200, 500, 300, 300));
    page = document.pages.add();

    //Layout Format
    PdfLayoutFormat layoutFormat = PdfLayoutFormat(
        layoutType: PdfLayoutType.paginate,
        breakType: PdfLayoutBreakType.fitPage);
//---
    String ownerText = "Owner: ";
    PdfTextElement textElement = PdfTextElement(
        text: ownerText,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 30,
            style: PdfFontStyle.bold));

    PdfLayoutResult result = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height),
        format: layoutFormat)!;

    String ownerNameText = users.name;
    textElement = PdfTextElement(
        text: ownerNameText,
        font: PdfStandardFont(
          PdfFontFamily.timesRoman,
          30,
        ));
    result = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, result.bounds.bottom, page.getClientSize().width, 0),
        format: layoutFormat)!;

//---
    String petName = "Petname: ";
    textElement = PdfTextElement(
        text: petName,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 30,
            style: PdfFontStyle.bold));
    result = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(0, result.bounds.bottom + 20,
            page.getClientSize().width, page.getClientSize().height),
        format: layoutFormat)!;

    String petNameText = listPet[index].petName;
    textElement = PdfTextElement(
        text: petNameText,
        font: PdfStandardFont(
          PdfFontFamily.timesRoman,
          30,
        ));
    result = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, result.bounds.bottom, page.getClientSize().width, 0),
        format: layoutFormat)!;

//-----
//---
    String petType = "Pet Type: ";
    textElement = PdfTextElement(
        text: petType,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 30,
            style: PdfFontStyle.bold));
    result = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(0, result.bounds.bottom + 20,
            page.getClientSize().width, page.getClientSize().height),
        format: layoutFormat)!;
    String petTypeText = listPet[index].petType;
    textElement = PdfTextElement(
        text: petTypeText,
        font: PdfStandardFont(
          PdfFontFamily.timesRoman,
          30,
        ));
    result = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, result.bounds.bottom, page.getClientSize().width, 0),
        format: layoutFormat)!;
//-----
//---
    String treamentHistory = "Treatment History";
    textElement = PdfTextElement(
        text: treamentHistory,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 30,
            style: PdfFontStyle.bold));
    result = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(0, result.bounds.bottom + 40,
            page.getClientSize().width, page.getClientSize().height),
        format: layoutFormat)!;
//-----

    //Create a PdfGrid
    PdfGrid grid = PdfGrid();

    //Add columns to grid
    grid.columns.add(count: 3);

    //Add headers to grid
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Date';
    header.cells[1].value = 'Veterinarian Name';
    header.cells[2].value = 'Notes';

    PdfGridStyle gridStyle = PdfGridStyle(
      cellSpacing: 2,
      cellPadding: PdfPaddings(left: 2, right: 3, top: 4, bottom: 5),
      borderOverlapStyle: PdfBorderOverlapStyle.overlap,
      // backgroundBrush: PdfBrushes.lightGray,
      // textPen: PdfPens.black,
      // textBrush: PdfBrushes.white,
      font: PdfStandardFont(PdfFontFamily.timesRoman, 24),
    );

    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    PdfGridRow row;
    for (var i = 0; i < bookingList.length; i++) {
      if (bookingList[i].petID == listPet[index].petID && bookingList[i].notes!='-') {
//---
        row = grid.rows.add();
        row.cells[0].value = formatter.format(
            DateTime.fromMillisecondsSinceEpoch(bookingList[i].dateBooking));

//-----
//---

        for (var v = 0; v < listVet.length; v++) {
          if (bookingList[i].DoctorID == listVet[v].userID) {
            row.cells[1].value = listVet[v].name;
          }
        }
        row.cells[2].value = bookingList[i].notes;
        
//-----
//-----
      }
    }
    grid.rows.applyStyle(gridStyle);
    header.style.backgroundBrush = PdfSolidBrush(PdfColor(255, 154, 167, 1));

    result = grid.draw(
        page: page,
        bounds: Rect.fromLTWH(0, result.bounds.bottom + 20,
            page.getClientSize().width, page.getClientSize().height),
        format: layoutFormat)!;

    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(
        bytes, 'Medical Report ' + listPet[index].petName + '.pdf');
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())?.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  }

  Future<void> getBookingHistory(ownerID) async {}

  Future<void> deletePet(dynamic petID) async {
    _servicePet.deletePet(petID);
  }
}
