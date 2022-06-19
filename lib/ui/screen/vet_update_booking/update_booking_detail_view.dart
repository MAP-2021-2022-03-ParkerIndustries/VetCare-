import 'package:flutter/material.dart';
import 'package:map_mvvm/view.dart';
import 'package:vetclinic/ui/screen/vet_update_booking/update_booking_detail_appbar.dart';
import 'package:vetclinic/ui/screen/vet_update_booking/update_booking_detail_body.dart';
import 'package:vetclinic/ui/screen/vet_update_booking/update_booking_detail_viewmodel.dart';

import '../../../model/Users.dart';
import '../../../model/booking.dart';
import '../../../model/pet.dart';

class UpdateBookingDetailView extends StatefulWidget {
  Booking booking;
  Pet pet;
  Users owner;
  UpdateBookingDetailView(
      {Key? key, required this.booking, required this.pet, required this.owner})
      : super(key: key);

  @override
  State<UpdateBookingDetailView> createState() =>
      _UpdateBookingDetailViewState();
}

class _UpdateBookingDetailViewState extends State<UpdateBookingDetailView> {
  @override
  Widget build(BuildContext context) {
     return View<UpdateBookingDetailVM>(builder: (context, viewModel) {
    return Scaffold(
        appBar: const UpdateBookingDetailAppbar(),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height:100),
              Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Text('Pet Name               :'),
                  
                  Text(widget.pet.petName),
                ],
              ),
             Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Text('Owner Name             :'),
                  
                  Text(widget.owner.name),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Text('Booking Date            :'),
                  
                  Text(widget.booking.dateBooking.toDate().toString()),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Text("Appointment Status     :"),
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
              )
            ],
          ),
        ));
  } );
   }
}
