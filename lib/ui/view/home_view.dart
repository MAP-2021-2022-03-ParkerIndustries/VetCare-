// package imports
import 'package:flutter/material.dart';
import 'package:vetclinic/app/app.dart';

// app imports
import 'package:vetclinic/ui/view/profile_view.dart';
import 'package:vetclinic/utils/app_theme.dart';
import 'package:vetclinic/viewmodel/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const HomeView());
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: const Text('Home Page'),
        automaticallyImplyLeading: false,
        actions: [
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
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
