import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/ui/components/search_bar.dart';

import '../../../model/booking.dart';
import '../../../model/pet.dart';
import 'history_viewmodel.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({Key? key}) : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  String _search = "";
  List<Pet> listpet = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: View<HistoryViewModel>(
        showProgressIndicator: true,
        builder: (context, viewModel) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: viewModel.listHistory.length,
            itemBuilder: (context, index) {
              //parse timestamp firebase into formatted string
              // DateTime dateTime = DateTime.parse(
              //     viewModel.listHistory[index].dateBooking.toDate().toString());
              // String formattedDateTime =
              //     DateFormat('dd-MM-yyyy').format(dateTime);
              DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                  viewModel.listHistory[index].dateBooking);
              String formattedDateTime =
                  DateFormat('dd-MM-yyyy').format(dateTime);

              //searching
              // bool check1 = "${viewModel.listHistory[index].animal}"
              //     .toLowerCase()
              //     .contains(_search.toLowerCase());
              // bool check2 = "${viewModel.listHistory[index].doctor}"
              //     .toLowerCase()
              //     .contains(_search.toLowerCase());
              bool check3 = "${viewModel.listHistory[index].paymentType}"
                  .toLowerCase()
                  .contains(_search.toLowerCase());
              // bool check4 =
              //     formattedDateTime.toLowerCase().contains(_search.toLowerCase());
              if (check3) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 6,
                  margin: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 160,
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
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text("Date Booking"),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(": $formattedDateTime"),
                                      ),
                                      const SizedBox(height: 15),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                            ": ${viewModel.listHistory[index].paymentType}"),
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  RatingBar(
                                    initialRating:
                                        viewModel.listHistory[index].rating,
                                    itemCount: 5,
                                    ratingWidget: RatingWidget(
                                      full: const Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                      ),
                                      half: const Icon(
                                        Icons.star_half,
                                        color: Colors.orange,
                                      ),
                                      empty: const Icon(Icons.star_outline),
                                    ),
                                    onRatingUpdate: (value) {
                                      setState(
                                        () {
                                          viewModel.listHistory[index].rating =
                                              value;
                                        },
                                      );
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      primary: Colors.blueAccent,
                                      backgroundColor: Colors.black,
                                      textStyle: const TextStyle(fontSize: 13)),
                                  // onPressed:viewModel.updateRate(viewModel.listHistory[index].bookingID, viewModel.listHistory[index].rating),
                                  onPressed: () async =>
                                      await viewModel.updateRate(
                                          viewModel
                                              .listHistory[index].bookingID,
                                          viewModel.listHistory[index].rating),
                                  child: const Text("Rate"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }
}
