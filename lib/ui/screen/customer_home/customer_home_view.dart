// package imports
import 'package:flutter/material.dart';
import 'package:vetclinic/app/app.dart';

// app imports

import 'package:vetclinic/utils/app_theme.dart';

class CustomerHomeView extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const CustomerHomeView());
  const CustomerHomeView({Key? key}) : super(key: key);

  @override
  State<CustomerHomeView> createState() => _CustomerHomeViewState();
}

class _CustomerHomeViewState extends State<CustomerHomeView> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primary,
          title: SizedBox(
            height: 35,
            child: Row(
              children: [
                Image.asset("assets/veterinarian.png", fit: BoxFit.cover),
                const SizedBox(width: 10),
                const Text(
                  "Customer Home Page",
                  style: AppTheme.headline3,
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.of(context).pushNamed(Routes.profileRoute);
              },
              icon: const Icon(Icons.notifications),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.profileRoute);
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: const [Text("Home")],
          ),
        ),
      ),
    );
  }
}
