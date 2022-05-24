import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/app/routes.dart';
import 'package:vetclinic/ui/components/custom_text_field.dart';

import 'package:vetclinic/utils/app_theme.dart';
import 'package:vetclinic/utils/validators.dart';
import 'package:vetclinic/ui/screen/register/register_viewmodel.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => RegisterView());
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formkey = GlobalKey<FormState>();

  String? name;

  String? email;

  String? password;

  String? confirm_password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 230, 204),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formkey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sign Up',
                      style: AppTheme.headline1,
                    ),
                    const SizedBox(height: 40),
                    _buildNameTextField(),
                    const SizedBox(height: 20),
                    _buildEmailTextField(),
                    const SizedBox(height: 20),
                    _buildPasswordTextField(),
                    const SizedBox(height: 20),
                    _buildConfirmPasswordTextField(),
                    _buildLogInButton(),
                    _buildRegisterButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameTextField() {
    return CustomTextField(
      onChanged: (input) => name = input,
      label: 'Name',
      hint: 'Enter your name',
      prefix: Icons.person,
      validator: (input) => Validator.validateName(name: input),
    );
  }

  Widget _buildEmailTextField() {
    return CustomTextField(
      onChanged: (input) => email = input,
      label: 'Email',
      hint: 'Enter your email',
      prefix: Icons.email,
      validator: (input) => Validator.validateEmail(email: input),
    );
  }

  Widget _buildPasswordTextField() {
    return CustomTextField(
      onChanged: (input) => password = input,
      label: 'Password',
      hint: 'Enter your password',
      prefix: Icons.lock,
      isHidden: true,
      validator: (input) => Validator.validatePassword(password: input),
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return CustomTextField(
      onChanged: (input) => confirm_password = input,
      label: 'Confirm Password',
      hint: 'Again Enter your password',
      prefix: Icons.lock,
      isHidden: true,
      validator: (input) => Validator.validateConfirmPassword(
          password: password, confirmPassword: input),
    );
  }

  Widget _buildLogInButton() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.loginRoute);
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(
          'Already have an account?',
          style: AppTheme.bodyText1.copyWith(
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return View<RegisterViewModel>(builder: (_, viewModel) {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppTheme.primary,
                textStyle: AppTheme.button,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              // onPressed: () => _formkey.currentState!.validate()
              //     ? _model.register().then((value) {
              //         if (!value) return;
              //         Navigator.of(_context).pushReplacementNamed(HomeView.id);
              //       })
              //     : null,
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
                  try {
                    await viewModel.register(name, email, password);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('New account...')));
                    Navigator.of(context).pushNamed(Routes.loginRoute);
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
                child: Text('Sign Up'),
              ),
            ),
          ),
        ],
      );
    });
  }
}
