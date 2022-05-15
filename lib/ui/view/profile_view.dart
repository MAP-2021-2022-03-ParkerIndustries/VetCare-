import 'package:vetclinic/enums/view_state.dart';
import 'package:vetclinic/ui/components/custom_text_field.dart';
import 'package:vetclinic/ui/view/base_view.dart';
import 'package:vetclinic/ui/view/login_view.dart';
import 'package:vetclinic/utils/app_theme.dart';
import 'package:vetclinic/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  static const String id = 'profile_view';
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BaseView<ProfileViewModel>(
      onModelReady: (model) => model.onModelReady(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.primary,
            title: const Text('Profile View'),
            actions: [
              IconButton(
                onPressed: () async {
                  await model.signout();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginView.id,
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          body: model.state == ViewState.BUSY
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: CircleAvatar(
                          child: Text(
                            (model.name).substring(0,1).toUpperCase(),
                             style: const TextStyle( fontSize: 30 ,color:Colors.black ),
                             
                          ),
                          maxRadius: 50,
                          backgroundColor: AppTheme.third,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Email:',
                              style: AppTheme.headline4,
                            ),
                            SizedBox(
                              width: size.width /1.3,
                              child: CustomTextField(
                                initialValue: model.email,
                                enabled: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Name:',
                            style: AppTheme.headline4,
                          ),
                          SizedBox(
                            width: size.width / 1.3,
                            child: CustomTextField(
                              controller: model.controller,
                              enabled: model.isEditing,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: model.isEditing
                    ? FloatingActionButton.extended(
                        onPressed: () {
                          model.cancelChanges();
                        },
                        label: const Text('Cancel'),
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  if (!model.isEditing) {
                    model.isEditing = !model.isEditing;
                    return;
                  }

                  if (!model.isChanged) return;
                  model.update();
                },
                backgroundColor: model.isEditing && !model.isChanged
                    ? AppTheme.primary.withOpacity(0.6)
                    : AppTheme.third,
                label:
                    model.isEditing ? const Text('Save') : const Text('Edit'),
                icon: model.isEditing
                    ? const Icon(Icons.save)
                    : const Icon(Icons.edit),
              ),
            ],
          ),
        );
      },
    );
  }
}
