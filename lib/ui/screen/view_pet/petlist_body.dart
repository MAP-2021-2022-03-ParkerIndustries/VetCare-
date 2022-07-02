import 'package:flutter/material.dart';
import 'package:map_mvvm/view.dart';
import 'package:vetclinic/app/app.dart';
import 'package:vetclinic/ui/screen/booking/booking_view.dart';
import 'package:vetclinic/ui/screen/view_pet/petList_view_Model.dart';

class PetListBody extends StatefulWidget {
  const PetListBody({Key? key}) : super(key: key);

  @override
  State<PetListBody> createState() => _PetListBodyState();
}

class _PetListBodyState extends State<PetListBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        View<PetListVM>(
          showProgressIndicator: true,
          builder: (context, viewModel) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: viewModel.listPet.length,
              itemBuilder: (context, index) {
                //parse timestamp firebase into formatted string
//  onTap:()=> viewModel.createPDF(index),//letak pge lasin... dplay biasa dulu
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 6,
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 200,
                      child: Row(children: [
                        Image.network(
                          viewModel.listPet[index].petImageURL,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text("Animal \n Type"),
                                    ),
                                    SizedBox(height: 15),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text("Name"),
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
                                      child: SizedBox(
                                        width: 50,
                                        child: Text(
                                            ": ${viewModel.listPet[index].petType}"),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: SizedBox(
                                        width: 50,
                                        child: Text(
                                            "\n: ${viewModel.listPet[index].petName}"),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookingView(
                                                          choosenPet:
                                                              viewModel.listPet[
                                                                  index]))),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .blueAccent // Background color
                                              ),
                                          child: const Text("Make\nBooking")),
                                      ElevatedButton(
                                          onPressed: () => {viewModel.createPDF(index)},
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .blueAccent // Background color
                                              ),
                                          child: const Text("Medical\nReport")),
                                      const SizedBox(height: 15),
                                      ElevatedButton(
                                          onPressed: () => {
                                                viewModel.deletePet(viewModel
                                                    .listPet[index].petID)
                                              },
                                              style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .redAccent // Background color
                                              ),
                                          child: const Text('Delete Pet'))
                                    ],
                                  ),
                                )
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
        )
      ],
    ));
  }
}
