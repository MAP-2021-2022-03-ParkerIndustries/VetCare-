import 'package:flutter/material.dart';
import 'package:vetclinic/utils/app_theme.dart';

class ProfileAppBar extends StatefulWidget {
  const ProfileAppBar({ Key? key }) : super(key: key);

  @override
  State<ProfileAppBar> createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          )
  }
}