import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:map_mvvm/view.dart';
import 'package:vetclinic/app/routes.dart';
import 'package:vetclinic/ui/components/custom_text_field.dart';
import 'package:vetclinic/ui/view/forgot_password_view.dart';
import 'package:vetclinic/ui/view/vet_home_view.dart';
import 'package:vetclinic/ui/view/register_view.dart';
import 'package:vetclinic/utils/app_theme.dart';
import 'package:vetclinic/viewmodel/vet_home_viewmodel.dart';
import 'package:vetclinic/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:vetclinic/utils/validators.dart';
import 'package:vetclinic/ui/view/login_view.dart';

class LoginView extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => LoginView());
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formkey = GlobalKey<FormState>();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 230, 204),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/VetCare_logo.png'),
                    const Text(
                      'Sign In',
                      style: AppTheme.headline1,
                    ),
                    const SizedBox(height: 40),
                    _buildEmailTextField(),
                    const SizedBox(height: 20),
                    _buildPasswordTextField(),
                    const SizedBox(height: 20),
                    _buildLoginButton(),
                    const SizedBox(height: 10),
                    _buildCreateAccountButton(),
                    _buildForgetPassword(),
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
    return CustomTextField(
      label: 'Email',
      onChanged: (input) {
        email = input;
      },
      hint: 'Enter your email',
      prefix: Icons.email,
      validator: (text) => Validator.validateEmail(email: email),
    );
  }

  Widget _buildPasswordTextField() {
    return CustomTextField(
      onChanged: (text) => password = text,
      label: 'Password',
      hint: 'Enter your password',
      prefix: Icons.lock,
      validator: (text) => Validator.validatePassword(password: text),
      isHidden: true,
    );
  }

  Widget _buildCreateAccountButton() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.registerRoute);
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(
          "Don't have an account? Create one",
          style: AppTheme.bodyText1.copyWith(
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return View<LoginViewModel>(builder: (_, viewModel) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
                  try {
                    await viewModel.login(email, password);
                    //insert personalization here

                    print(viewModel.users.role);

                    if (viewModel.users.role == 'vet') {
                      Navigator.of(context).pushNamed(Routes.vetHomeRoute);
                    }
                    else{
                      Navigator.of(context).pushNamed(Routes.customerHomeRoute);
                    }
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
                child: Text('Log In'),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildForgetPassword() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(Routes.forgotPassRoute);
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(
          "Forget Password",
          style: AppTheme.bodyText1.copyWith(
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }
}
