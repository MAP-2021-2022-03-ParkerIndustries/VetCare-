import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map_mvvm/failure.dart';
import 'package:map_mvvm/view.dart';
import 'package:vetclinic/ui/components/custom_text_field.dart';
import 'package:vetclinic/ui/screen/booking/booking_viewmodel.dart';
import 'package:vetclinic/ui/screen/vet_booking_list/booking_list_viewmodel.dart';

import '../../../app/routes.dart';
import '../../../model/Users.dart';
import '../../../model/pet.dart';
import '../../../utils/app_theme.dart';

class BookingView extends StatefulWidget {
  Pet choosenPet;

  BookingView({Key? key, required this.choosenPet}) : super(key: key);

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  Users selectedVet = Users();
  var selectedDate;
  var paymentType='Cash';
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
          padding: const EdgeInsets.only(top: 10.0, bottom: 0, left: 10),
          child: Container(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Booking Date: '),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 290,
                            height: 100,
                            child: DatePicker(
                              DateTime.now(),
                              initialSelectedDate: DateTime.now(),
                              selectionColor: Colors.black,
                              selectedTextColor: Colors.white,
                              onDateChange: (date) {
                                // New date selected
                                setState(() {
                                  selectedDate = date;
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                   Padding(
                     padding: const EdgeInsets.only(top: 50),
                     child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: SizedBox(
                            width: 100,
                            height: 70,
                            child: Text('Payment Method: ', style: AppTheme.bodyText2,),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          height: 70,
                          child: _choosePaymentMethod(),
                        )
                      ],
                  ),
                   ),
                  Row(
                    children: [
                      const SizedBox(height: 100),
                      SizedBox(
                          width: 250,
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                setState(() async {
                                  selectedVet =
                                      (await _buildDoctorNameField(viewModel))
                                          as Users;
                                });
                              } catch (e) {
                                print('Input Cannot Be Null');
                              }
                            },
                            child: selectedVet.name == null
                                ? const Text('Select Veterinarian')
                                : Text('Vet: Dr ${selectedVet.name}'),
                          )
                          // _buildDoctorNameField(viewModel)
                          ),
                    ],
                  ),
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 200),
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

  Future<Users?> _buildDoctorNameField(viewModel) async {
    return await showDialog<Users>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select'),
          children: [
            Container(
              height: 300,
              width: 300,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: viewModel.listVet.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    child: SimpleDialogOption(
                      onPressed: () =>
                          {Navigator.pop(context, viewModel.listVet[index])},
                      child: Text(" ${viewModel.listVet[index].name}"),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _choosePaymentMethod(){
    return DropdownButton<String>(
      value: paymentType,
      icon: const Icon(Icons.arrow_drop_down_outlined),
      onChanged: (String? newValue) {
        setState(() {
          paymentType = newValue!;
        });
      },
      items: <String>['Cash', 'Debit']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
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
             
                await viewmodel.create(selectedVet,widget.choosenPet,selectedDate,paymentType);
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
