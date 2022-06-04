import 'package:duration_button/duration_button.dart';
import 'package:map_mvvm/failure.dart';
import 'package:map_mvvm/view.dart';
import 'package:vetclinic/app/app.dart';
import 'package:vetclinic/ui/components/custom_text_field.dart';
import 'package:vetclinic/utils/app_theme.dart';
import 'package:vetclinic/ui/screen/profile/profile_viewmodel.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const ProfileView());
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileView();
}

class _ProfileView extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    bool signedOut = false;
    return View<ProfileViewModel>(
      builder: ((_, model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.primary,
            title: const Text('Profile View'),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    model.updateOnLoad();
                  });
                },
                icon: const Icon(Icons.replay_outlined),
              ),
              IconButton(
                onPressed: () async {
                  signedOut = await model.signout();
                  if (signedOut) {
                    Navigator.pushNamedAndRemoveUntil(context, Routes.loginRoute, (route) => false);
                  }
                },
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _userAvatar(model),
                    _userEmail(model, size),
                    _userName(model, size),
                  ],
                ),
              )),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppTheme.primary,
                        textStyle: AppTheme.button,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          setState(() {
                            model.updateUser();
                            model.updateOnLoad();
                          });
                        } on Failure catch (e) {
                          final snackbar = SnackBar(
                            content: Text(e.message ?? 'Error'),
                            backgroundColor: Colors.red,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                      },
                      child: const Text('Update Profile'),
                    ),
                  ]))
            ],
          ),
        );
      }),
    );
  }

  Widget _userAvatar(model) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: CircleAvatar(
        child: Text(
          (model.users.name)!.substring(0, 1).toUpperCase(),
          style: const TextStyle(fontSize: 30, color: Colors.black),
        ),
        maxRadius: 50,
        backgroundColor: AppTheme.third,
      ),
    );
  }

  Widget _userEmail(model, size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Email:',
          style: AppTheme.headline4,
        ),
        SizedBox(
          width: size.width / 1.3,
          child: CustomTextField(
            initialValue: model.users.email,
            enabled: false,
          ),
        ),
      ],
    );
  }

  Widget _userName(model, size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Name:',
          style: AppTheme.headline4,
        ),
        SizedBox(
          width: size.width / 1.3,
          child: CustomTextField(
            controller: model.nameController,
          ),
        ),
      ],
    );
  }

  // Widget _buildUpdateButton(model) {
  //   return
  // }
}
