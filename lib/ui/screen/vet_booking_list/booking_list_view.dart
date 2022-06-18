import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vetclinic/ui/screen/vet_booking_list/booking_list_appBar.dart';
import 'package:vetclinic/ui/screen/vet_booking_list/booking_list_body.dart';

class VetBookingListView extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const VetBookingListView());
  
  const VetBookingListView({Key? key}) : super(key: key);

  @override
  State<VetBookingListView> createState() => _VetBookingListViewState();
}

class _VetBookingListViewState extends State<VetBookingListView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: VetBookingListAppBar(),
      body: VetBookingListBody(),
    );
  }
}