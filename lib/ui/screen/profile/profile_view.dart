import 'package:duration_button/duration_button.dart';
import 'package:file_picker/file_picker.dart';
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
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
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
                    const SizedBox(height: 30),
                    _userAvatar(model),
                    _userEmail(model, size),
                    const SizedBox(height: 10),
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
    return Center(
      child: SizedBox(
          height: 300,
          child: Stack(children: [
            CircleAvatar(
              maxRadius: 100,
              backgroundImage: NetworkImage(model.users.profileImg),
            ),
            Positioned(
                right: 10,
                bottom: 100,
                child: IconButton(
                  onPressed: () async {
                    final results = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'png']);

                    if (results == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No file selected')),
                      );
                      return null;
                    }
                    final path = results.files.single.path!;
                    final fileName = results.files.single.name;
                    model.uploadProfileImage(path, fileName);
                    setState(() {
                      model.updateUser();
                    });
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    size: 50,
                  ),
                ))
          ])),
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
