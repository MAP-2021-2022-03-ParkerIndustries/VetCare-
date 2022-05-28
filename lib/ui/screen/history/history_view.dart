import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/app/app.dart';
import 'package:vetclinic/ui/screen/history/history_viewmodel.dart';
import 'package:vetclinic/utils/app_theme.dart';

class HistoryView extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const HistoryView());
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
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
                  "Pet History",
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
      body: Center(child: _buildHistoryCard()
          ),
    );
  }

  Widget _buildHistoryCard() {
    return View<HistoryViewModel>(
      showProgressIndicator: true,
      builder: (context, viewModel) {
        return ListView.builder(
          itemCount: viewModel.listHistory.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 6,
              margin: const EdgeInsets.all(10),
              child:
                  // ListTile(
                  //   leading: const Icon(Icons.health_and_safety),
                  //   title: Text(viewModel.listHistory[index].animal),
                  // ),
                  Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 150,
                  child: Row(children: [
                    Image.asset("assets/cat.png"),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                  "Animal Type : ${viewModel.listHistory[index].animal}"),
                            ),
                            // Text(viewModel.listHistory[index].dateBooking.toString()),
                            const SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                  "Doctor Assigned : ${viewModel.listHistory[index].doctor}"),
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                  "Payment Type : ${viewModel.listHistory[index].paymentType}"),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
