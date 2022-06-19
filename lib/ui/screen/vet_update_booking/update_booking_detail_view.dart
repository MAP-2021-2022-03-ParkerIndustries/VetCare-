import 'package:flutter/material.dart';
import 'package:vetclinic/ui/screen/vet_update_booking/update_booking_detail_appbar.dart';
import 'package:vetclinic/ui/screen/vet_update_booking/update_booking_detail_body.dart';

import '../../../model/Users.dart';
import '../../../model/booking.dart';
import '../../../model/pet.dart';


class UpdateBookingDetailView extends StatefulWidget {
  Booking booking;
  Pet pet;
  Users owner;
   UpdateBookingDetailView({Key? key, required this.booking,required this.pet, required this.owner}) : super(key: key);

  @override
  State<UpdateBookingDetailView> createState() => _UpdateBookingDetailViewState();
}

class _UpdateBookingDetailViewState extends State<UpdateBookingDetailView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: UpdateBookingDetailAppbar(),
      
      body: Center(
        child: Column(
          children: [
            Text('Pet Name: ${widget.pet.petName}'),
            Text('Owner: ${widget.owner.name} '),
            Text('Booking Date:${widget.booking.dateBooking.toDate().toString()}'),

          ],
        ),
      )
    );
  }
}