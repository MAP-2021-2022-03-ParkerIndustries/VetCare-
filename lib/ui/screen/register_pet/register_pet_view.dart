import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/ui/screen/register_pet/register_pet_viewmodel.dart';
import 'package:vetclinic/utils/validators.dart';

import '../../../app/routes.dart';
import '../../../utils/app_theme.dart';
import '../../components/custom_text_field.dart';

class RegisterPetView extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const RegisterPetView());
  const RegisterPetView({Key? key}) : super(key: key);
@override
  State<RegisterPetView> createState() => _RegisterPetState();
}

class _RegisterPetState extends State<RegisterPetView> {
  String petType = 'Dog';
  String? petName;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                "Register Pet",
                style: AppTheme.headline3,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Register a pet',
                        style: AppTheme.headline1,
                      )),
                  const SizedBox(height: 20),
                  _buildPetNameTextField(),
                  const SizedBox(height: 20),
                  Row(children: [
                    const Text(
                      'Pet Type: ',
                      style: AppTheme.headline4,
                    ),
                    const SizedBox(width: 20),
                    _buildPetTypeField(),
                  ]),

                  const SizedBox(width: 20),
                  _buildPetRegisterButton(),
                ],
              )))),
    );
  }

  Widget _buildPetTypeField() {
    return DropdownButton<String>(
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
    );
  }

  Widget _buildPetNameTextField() {
    return CustomTextField(
      onChanged: (input) => petName = input,
      label: "Pet Name",
      hint: "Enter Pet Name",
      validator: (input) => Validator.validateName(name: petName),
    );
  }

  Widget _buildPetRegisterButton() {
    return View<RegisterPetVM>(builder: (_, viewModel) {
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
                  await viewModel.registerPet(petType, petName);
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
    });
  }
}
