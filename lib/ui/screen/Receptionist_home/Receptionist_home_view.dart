import 'package:flutter/material.dart';

import '../../../app/routes.dart';
import '../../../utils/app_theme.dart';

class ReceptionistHomeView extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const ReceptionistHomeView());
  const ReceptionistHomeView({Key? key}) : super(key: key);

  @override
  State<ReceptionistHomeView> createState() => _ReceptionistHomeViewState();
}

class _ReceptionistHomeViewState extends State<ReceptionistHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: SizedBox(
          height: 35,
          child: Row(
            children: [
              Image.asset("assets/veterinarian.png", fit: BoxFit.cover),
              const SizedBox(width: 10),
              const Text(
                "Receptionist Page",
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
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(4, (index) {
          return Center(
              child: index == 0

                  //Register pet Grid
                  ? Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(Routes.receptionistEditRoute);
                          },
                          icon: Image.asset('assets/EditBooking.jpg'),
                          iconSize: 150,
                        ),
                        const Text('Edit Booking'),
                      ],
                    )

                  //Make a booking grid
                  : index == 1
                      ? Column(children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.bookingPetRoute);
                            },
                            icon: Image.asset('assets/cat.png'),
                            iconSize: 150,
                          ),
                          const Text('Make a booking'),
                        ])
                      : Text('Item $index'));
        }),
      ),
    );
  }
}
