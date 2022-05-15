import 'package:vetclinic/ui/components/custom_text_field.dart';
import 'package:vetclinic/ui/view/base_view.dart';

import 'package:vetclinic/ui/view/login_view.dart';
import 'package:vetclinic/utils/app_theme.dart';
import 'package:vetclinic/viewmodel/forgot_password_viewmodel.dart';

import 'package:flutter/material.dart';

class ForgotPasswordView extends StatelessWidget {
  static const String id = 'forgot_password_view';
  ForgotPasswordView({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  late final ForgotPasswordViewModel _model;
  late final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewModel>(
      onModelReady: (model) {
        _model = model;
        _context = context;
        model.onModelReady();
      },
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color.fromARGB(255, 255, 230, 204),
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
                          'Reset Password',
                          style: AppTheme.headline1,
                        ),
                        const SizedBox(height: 40),
                        _buildEmailTextField(),
                        const SizedBox(height: 20),
                        
                        _buildForgotPasswordButton(),
                      ],
                    ),
                  ),
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
      controller: _model.emailController,
      label: 'Email',
      hint: 'Enter your email',
      prefix: Icons.email,
      validator: _model.emailValidator,
    );
  }

  Widget _buildForgotPasswordButton() {
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
            onPressed: () => _formkey.currentState!.validate()
                ? _model.reset().then((value) {
      
                    Navigator.of(_context).pushReplacementNamed(LoginView.id);
                  })
                : null,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Reset Password'),
            ),
          ),
        ),
      ],
    );
  }
}
