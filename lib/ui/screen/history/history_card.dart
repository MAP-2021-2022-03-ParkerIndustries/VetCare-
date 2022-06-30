import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/ui/components/search_bar.dart';

import 'history_viewmodel.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({ Key? key }) : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  String _search = "";
  
  @override
  Widget build(BuildContext context) {
    return View<HistoryViewModel>(
      showProgressIndicator: true,
      builder: (context, viewModel) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: viewModel.listHistory.length,
          itemBuilder: (context, index) {
            //parse timestamp firebase into formatted string
            DateTime dateTime = DateTime.parse(
                viewModel.listHistory[index].dateBooking.toDate().toString());
            String formattedDateTime =
                DateFormat('dd-MM-yyyy').format(dateTime);

            //searching
            bool check1 = "${viewModel.listHistory[index].animal}"
                .toLowerCase()
                .contains(_search.toLowerCase());
            bool check2 = "${viewModel.listHistory[index].doctor}"
                .toLowerCase()
                .contains(_search.toLowerCase());
            bool check3 = "${viewModel.listHistory[index].paymentType}"
                .toLowerCase()
                .contains(_search.toLowerCase());
            bool check4 =
                formattedDateTime.toLowerCase().contains(_search.toLowerCase());
            if (check1 || check2 || check3 || check4) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 6,
                margin: const EdgeInsets.all(10),
                child: Padding(
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
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text("Animal Type"),
                                  ),
                                  SizedBox(height: 15),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text("Date Booking"),
                                  ),
                                  SizedBox(height: 15),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text("Doctor Assigned"),
                                  ),
                                  SizedBox(height: 15),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text("Payment Type"),
                                  ),
                                  SizedBox(height: 15),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                        ": ${viewModel.listHistory[index].animal}"),
                                  ),
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(": $formattedDateTime"),
                                  ),
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                        ": ${viewModel.listHistory[index].doctor}"),
                                  ),
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                        ": ${viewModel.listHistory[index].paymentType}"),
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }
  }
