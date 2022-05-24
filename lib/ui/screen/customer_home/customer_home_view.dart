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
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.primary,
        selectedItemColor: Colors.white,
        unselectedItemColor: AppTheme.second,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, Routes.customerHomeRoute);
              break;
            case 1:
              Navigator.pushNamed(context, Routes.historyRoute);
              break;
            default:
          }
        },
      ),
    );
  }
}
