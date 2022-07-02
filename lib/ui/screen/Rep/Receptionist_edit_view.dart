import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';

import 'package:vetclinic/ui/components/custom_text_field.dart';
import 'package:vetclinic/ui/screen/Rep/Reception_edit_viewmodel.dart';
import '../../../app/routes.dart';
import '../../../model/Users.dart';
import '../../../utils/app_theme.dart';

class ReceptionistEditBookingView extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => ReceptionistEditBookingView());
  ReceptionistEditBookingView({Key? key}) : super(key: key);

  Users users = Users();
  String transaction = 'Unpaid';
  final _formkey = GlobalKey<FormState>();
  @override
  State<ReceptionistEditBookingView> createState() =>
      _ReceptionistEditBookingViewState();
}

class _ReceptionistEditBookingViewState
    extends State<ReceptionistEditBookingView> {
  @override
  Widget build(BuildContext context) {
    return View<EditBookingViewModel>(builder: (_, model) {
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
                  "Edit Booking",
                  style: AppTheme.headline3,
                ),
                const SizedBox(width: 10),
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
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(height: 70, width: 100, child: _buildEdit(model)),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 70,
                      width: 100,
                      child: _buildTransaction(widget.transaction)),
                ),
              ],
            ),
             Row(
               children: [
                 SizedBox(
                      height: 70,
                      width: 100,
                      child: _buildTransactionForm(model)),
               ],
             )
          ],
        ),
      );
    });
  }

  Widget _buildEdit(EditBookingViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextField(
        label: "${model.user.name}",
        enabled: false,
      ),
    );
  }

  Widget _buildTransaction(String Transaction) {
    return DropdownButton<String>(
      value: Transaction,
      icon: const Icon(Icons.arrow_drop_down_outlined),
      onChanged: (String? newValue) {
        setState(() {
          Transaction = newValue!;
        });
      },
      items: <String>[
        'Done',
        'Unpaid',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
  Widget _buildTransactionForm(EditBookingViewModel viewModel) {
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
            if (widget._formkey.currentState!.validate()) {
              try {
              //  await viewModel.isListeningTovetBookingServiceStream; 
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
            child: Text('Register Pet'),
          ),
        ),
      )
    ]);
  }
}
