import 'package:flutter/material.dart';
import 'package:vetcare/vetcare.dart';
import '../../screens/home/home_viewmodel.dart';
import '../../ui_utils.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          View<HomeViewmodel>(
   
          ),
        ],
      ),
    );
  }
}
