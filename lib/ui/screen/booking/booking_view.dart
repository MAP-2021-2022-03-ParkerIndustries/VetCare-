import 'package:flutter/material.dart';

class BookingView extends StatefulWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Page"),
        
      ),
      // body: Center(child: )),
    );
  }
}
