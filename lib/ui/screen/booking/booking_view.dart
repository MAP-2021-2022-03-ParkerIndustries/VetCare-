import 'package:flutter/material.dart';
import 'package:vetclinic/ui/components/custom_text_field.dart';

import '../../../utils/app_theme.dart';

class BookingView extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const BookingView());
  const BookingView({Key? key}) : super(key: key);

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primary,
          title: Text("Booking Page"),
        ),
        body: Center(child: Form(child: Text("macibai"))));
  }
  Widget _buildVetNameTextField()
  {
    return TextFormField(
      
      
      

    );

  }
}

