import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/app/app.dart';
import 'package:vetclinic/ui/components/custom_text_field.dart';

import 'package:vetclinic/utils/app_theme.dart';
import 'package:vetclinic/utils/validators.dart';
import 'package:vetclinic/ui/screen/forgot_password/forgot_password_viewmodel.dart';

import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);
  static Route route() =>
      MaterialPageRoute(builder: (_) => const ForgotPasswordView());

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  String? email;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 230, 204),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reset Password',
                      style: AppTheme.headline1,
                    ),
                    const SizedBox(height: 40),
                    _buildEmailTextField(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildBackButton(),
                        _buildForgotPasswordButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return View<ForgotPasswordViewModel>(
      builder: (_, viewModel) => CustomTextField(
        label: 'email',
        onChanged: (input) {
          email = input;
        },
        validator: (text) => Validator.validateEmail(email: email),
        hint: 'Enter your email',
        prefix: Icons.email,
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return View<ForgotPasswordViewModel>(
      builder: (_, viewModel) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AppTheme.primary,
          textStyle: AppTheme.button,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            try {
              await viewModel.reset(email);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Password reset sent to email"),
                ),
              );
              Navigator.of(context).pushNamed(Routes.loginRoute);
            } on Failure catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.message ?? 'Error'),
                ),
              );
            }
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Reset Password'),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: AppTheme.primary,
        textStyle: AppTheme.button,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.loginRoute);
      },
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text('Back'),
      ),
    );
  }
}
