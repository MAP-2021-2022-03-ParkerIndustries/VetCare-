import 'package:flutter/cupertino.dart';


import '../../../model/Users.dart';
import '../../../model/booking.dart';
import '../../../model/pet.dart';

class UpdateBookingDetailBody extends StatefulWidget {
   Booking booking;
  Pet pet;
  Users owner;
   UpdateBookingDetailBody({Key? key,required this.booking,required this.pet, required this.owner}) : super(key: key);

  @override
  State<UpdateBookingDetailBody> createState() => _UpdateBookingDetailBodyState();
}

class _UpdateBookingDetailBodyState extends State<UpdateBookingDetailBody> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
      ],
    );
  }
}