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

  final _formkey = GlobalKey<FormState>();
  TextEditingController _controller= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: Text("Booking Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0 ,bottom:10 ),
        child: Container(
          child: Form(
            key: _formkey,
            child: Row(
              children: [
                _buildVetNameTextField(),
                _buildPetTypeField()
              ],
            ),
          ),
        ),
      ),
      
    );
  }

  Widget _buildVetNameTextField() {
    return TextFormField(
      decoration: const InputDecoration(
    icon: Icon(Icons.person),
    hintText: 'Enter you pet Name',
    labelText: 'Pet Name',
  ),

      
    );
  }
}

Widget _buildPetTypeField() {
    return DropdownButton<String>(
      
      value: "Dog",
      icon: const Icon(Icons.arrow_drop_down_outlined),
      onChanged: (String? newValue) {
        
      },
      items: <String>['Dog', 'Cat', 'Rabbit', 'Bird']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

