// package imports
import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vetclinic/app/app.dart';
import 'package:vetclinic/ui/screen/vet_home/vet_home_viewmodel.dart';

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
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          backgroundColor: AppTheme.primary,
          title: const Text(' Vet Home Page'),
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
      ),
      body: View<VetHomeViewModel>(
        builder: (context,viewModel) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      "Ratings",
                      style: AppTheme.headline1,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text("5"),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text("4"),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text("3"),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text("2"),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text("1"),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: LinearPercentIndicator(
                              width: 200.0,
                              lineHeight: 8.0,
                              // percent: 0.5,
                              percent:  viewModel.Rating5(),
                              progressColor: Colors.blue,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: LinearPercentIndicator(
                              width:200.0,
                              lineHeight: 8.0,
                              percent:viewModel.Rating4(),
                              progressColor: Colors.blue,
                        
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: LinearPercentIndicator(
                              width: 200.0,
                              lineHeight: 8.0,
                              percent:viewModel.Rating3(),
                              progressColor: Colors.blue,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: LinearPercentIndicator(
                              width: 200.0,
                              lineHeight: 8.0,
                              percent: viewModel.Rating2(),
                              progressColor: Colors.blue,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: LinearPercentIndicator(
                              width: 200.0,
                              lineHeight: 8.0,
                              percent: viewModel.Rating1(),
                              progressColor: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  
  }

}
