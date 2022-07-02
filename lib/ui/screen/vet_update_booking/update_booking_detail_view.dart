import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map_mvvm/view.dart';
import 'package:vetclinic/ui/screen/vet_update_booking/update_booking_detail_appbar.dart';
import 'package:vetclinic/ui/screen/vet_update_booking/update_booking_detail_body.dart';
import 'package:vetclinic/ui/screen/vet_update_booking/update_booking_detail_viewmodel.dart';
import 'package:vetclinic/utils/app_theme.dart';

import '../../../model/Users.dart';
import '../../../model/booking.dart';
import '../../../model/pet.dart';

class UpdateBookingDetailView extends StatefulWidget {
  Booking booking;
  Pet pet;
  Users owner;
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  UpdateBookingDetailView(
      {Key? key, required this.booking, required this.pet, required this.owner})
      : super(key: key);

  @override
  State<UpdateBookingDetailView> createState() =>
      _UpdateBookingDetailViewState();
}

class _UpdateBookingDetailViewState extends State<UpdateBookingDetailView> {
  late TextEditingController noteController=TextEditingController();
  String notes='';
  @override
  Widget build(BuildContext context) {
    return View<UpdateBookingDetailVM>(builder: (context, viewModel) {
      return Scaffold(
          appBar: const UpdateBookingDetailAppbar(),
          body: Column(
            children: [
              const SizedBox(
                width: 30,
                height: 20,
              ),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: CircleAvatar(
                    maxRadius: 100,
                    backgroundImage: NetworkImage(widget.pet.petImageURL),
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const Text(
                    'Pet Name',
                    style: AppTheme.headline3,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Text(widget.pet.petName, style: AppTheme.headline4),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const Text('Owner Name', style: AppTheme.headline3),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 75),
                    child: Text(widget.owner.name, style: AppTheme.headline4),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const Text('Booking Date', style: AppTheme.headline3),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Text(
                        widget.formatter
                            .format(DateTime.fromMillisecondsSinceEpoch(widget.booking.dateBooking)),
                        style: AppTheme.headline4),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const Text("Appointment Status   ", style: AppTheme.headline3),
                  DropdownButton<String>(
                    value: widget.booking.appointmentStatus,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.booking.appointmentStatus = newValue!;
                      });
                    },
                    items: <String>[
                      'Booked',
                      'Postponed',
                      'Ongoing',
                      'Done',
                      'Absent'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const Text('Notes', style: AppTheme.headline3),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 75),
                    child: Text(widget.booking.notes, style: AppTheme.headline4),
                  ),
                ],
              ),
              const SizedBox(
                    height: 30,
                  ),
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  TextButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        textStyle: AppTheme.button,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      onPressed: () async {
                        await viewModel.updateData(widget.booking.bookingID,
                            widget.booking.appointmentStatus, widget.booking.notes);
                      },
                      child: const Text("Update Status")),
                      const SizedBox(
                    width: 30,
                  ),
                  TextButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        textStyle: AppTheme.button,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      onPressed: () async {
                        final notes=(await openNotes());
                        if(notes==null||notes.isEmpty)return;
                        setState(() {
                          widget.booking.notes=notes;
                        });
                      },
                      child:  Text("Notes")),
                ],
              ),

              
            ],
          ));
    });
  }

  Future<String?> openNotes()=>showDialog<String>(context: context, 
  builder: (context)=>AlertDialog(
      title: Text('Treatment Notes'),
      content: TextField(
        autofocus: true,
        controller: noteController,
         //put controller later
      ),
      actions: [
        TextButton(onPressed: (){Navigator.of(context).pop(noteController.text);}, child: Text('Save'))
      ],
  ));
}
