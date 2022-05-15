// package imports
import 'package:flutter/material.dart';

// app imports
import 'package:vetclinic/enums/view_state.dart';
import 'package:vetclinic/ui/view/base_view.dart';
import 'package:vetclinic/ui/view/profile_view.dart';
import 'package:vetclinic/utils/app_theme.dart';
import 'package:vetclinic/viewmodel/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  static const String id = 'home_view';
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (HomeViewModel model) => model.onModelReady(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.primary,
            title: const Text('Home Page'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ProfileView.id);
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
            currentIndex: model.currentIndex,
            onTap: (index) {
              model.currentIndex = index;
              // Dismiss the current snackbar if any
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            },
          ),
        );
      },
    );
  }
}
