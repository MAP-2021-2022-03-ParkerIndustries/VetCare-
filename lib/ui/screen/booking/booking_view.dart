import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map_mvvm/failure.dart';
import 'package:map_mvvm/view.dart';
import 'package:vetclinic/ui/components/custom_text_field.dart';
import 'package:vetclinic/ui/screen/booking/booking_viewmodel.dart';
import 'package:vetclinic/ui/screen/vet_booking_list/booking_list_viewmodel.dart';

import '../../../app/routes.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/validators.dart';

class BookingView extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const BookingView());
  const BookingView({Key? key}) : super(key: key);

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  String petType = 'Dog';
  String DoctorName='';
  @override
  Widget build(BuildContext context) {
    return View<BookingViewModel>(builder: (_, viewModel) {
      return Scaffold(
        appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: SizedBox(
          height: 35,
          child: Row(
            children: [
              Image.asset("assets/veterinarian.png", fit: BoxFit.cover),
              const SizedBox(width: 10),
              const Text(
                "Booking Page",
                style: AppTheme.headline4,
              ),
             
            ],
          ),
        ),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.of(context).pushNamed(Routes.profileRoute);
            },
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              
              Navigator.of(context).pushNamed(Routes.profileRoute);
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 0),
          child: Container(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 200,
                          height: 70,
                          child: _buildVetNameTextField(viewModel)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      children: [
                        SizedBox(child: _buildPetTypeField()),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 250,
                          height: 70,
                          child: _buildDoctorNameField()),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 250,
                        height: 70,
                        child: _buildPetBookingButton(viewModel),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildVetNameTextField(viewModel) {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Enter your pet Name',
        labelText: 'Pet Name',
      ),
    );
  }

  Widget _buildPetTypeField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(Icons.pets),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: DropdownButton<String>(
            value: petType,
            icon: const Icon(Icons.arrow_drop_down_outlined),
            onChanged: (String? newValue) {
              setState(() {
                petType = newValue!;
              });
            },
            items: <String>['Dog', 'Cat', 'Rabbit', 'Bird']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorNameField() {
    return TextFormField(
      controller: _controller,
      onChanged: (input)=>DoctorName=input,
      decoration: const InputDecoration(
          icon: Icon(Icons.local_hospital_outlined),
          hintText: 'Input the Doctor Name',
          labelText: 'Doctor Name'),
        validator: (input) => Validator.validateName(name:DoctorName ),
    );
  }

  Widget _buildPetBookingButton(viewmodel) {
    return Row(children: [
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppTheme.primary,
            textStyle: AppTheme.button,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          onPressed: () async {
            if (_formkey.currentState!.validate()) {
              try {
                await viewmodel.create(viewmodel);
                Navigator.of(context).pushNamed(Routes.customerHomeRoute);
              } on Failure catch (e) {
                final snackbar = SnackBar(
                  content: Text(e.message ?? 'Error'),
                  backgroundColor: Colors.red,
                );

                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
            }
          },
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Confirm Booking'),
          ),
        ),
      )
    ]);
  }
}
