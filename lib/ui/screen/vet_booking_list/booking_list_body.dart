import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/model/pet.dart';
import 'package:vetclinic/model/Users.dart';
import 'package:vetclinic/ui/screen/vet_booking_list/booking_list_viewmodel.dart';

class VetBookingListBody extends StatefulWidget {
  const VetBookingListBody({Key? key}) : super(key: key);

  @override
  State<VetBookingListBody> createState() => _VetBookingListBodyState();
}

class _VetBookingListBodyState extends State<VetBookingListBody> {
  @override
  Widget build(BuildContext context) {
    return View<VetBookingListVM>(builder: (context, viewModel) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.listBooking.length,
        itemBuilder: (context, index) {
          //parse timestamp firebase into formatted string
          DateTime dateTime = DateTime.parse(
              viewModel.listBooking[index].dateBooking.toDate().toString());
          String formattedDateTime = DateFormat('dd-MM-yyyy').format(dateTime);
          //get petinfo
          // viewModel.readPetInfo();
          //searching

          return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 6,
              margin: const EdgeInsets.all(10),
              child: FutureBuilder<Pet>(
                future: viewModel.readPetInfo(index),
                builder: (BuildContext context, AsyncSnapshot<Pet> snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 170,
                        child: Row(children: [
                          Image.network(
                            viewModel.pet.petImageURL,
                            width: 100,
                          ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text("Pet Name"),
                                      ),
                                      SizedBox(height: 15),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text("Date Booking"),
                                      ),
                                      SizedBox(height: 15),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text("Owner Name"),
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
                                        child:
                                            Text(": ${viewModel.pet.petName}"),
                                      ),
                                      const SizedBox(height: 15),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(": $formattedDateTime"),
                                      ),
                                      const SizedBox(height: 15),
                                      FutureBuilder<Users>(
                                          future:
                                              viewModel.readOwnerInfo(index),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<Users> snapshot) {
                                            if (snapshot.hasData) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                    ": ${viewModel.owner.name}"),
                                              );
                                            } else {
                                              return const SizedBox(
                                                width: 60,
                                                height: 60,
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          }
                                         
                                          ),
                                      const SizedBox(height: 15),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                            ": ${viewModel.listBooking[index].paymentType}"),
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
                    );
                  } else {
                    return const SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ));
        },
      );
    });
  }
}
