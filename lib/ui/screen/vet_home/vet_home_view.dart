// package imports
import 'package:flutter/material.dart';
import 'package:vetclinic/app/app.dart';

// app imports

import 'package:vetclinic/utils/app_theme.dart';

class VetHomeView extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const VetHomeView());
  const VetHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:Size.fromHeight(200),
        child: AppBar(
         shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30),),
         ),
          backgroundColor: AppTheme.primary,
          title: const Text(' Vet Home Page'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.vetBookingListRoute);
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: const [Text("Welcome",style: AppTheme.headline1,)],
        ),
      ),
    );
  }
}
