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
      builder: (context, model, child) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
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
