import 'package:vetclinic/ui/view/home_view.dart';
import 'package:vetclinic/ui/view/login_view.dart';
import 'package:vetclinic/ui/view/base_view.dart';
import 'package:vetclinic/viewmodel/startup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:vetclinic/viewmodel/startup_viewmodel.dart';

import 'base_view.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<StartUpViewModel>(
      builder: (context, model, child) =>Scaffold(
         backgroundColor: const Color.fromARGB(255, 255, 230, 204),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height:50),
              Image.asset('assets/VetCare_logo.png'),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
      onModelReady: (model) {
        model.onModelReady().then(
              (value) => Navigator.of(context).pushReplacementNamed(
                value ? HomeView.id : LoginView.id,
              ),
            );
      },
    );
  }
}
