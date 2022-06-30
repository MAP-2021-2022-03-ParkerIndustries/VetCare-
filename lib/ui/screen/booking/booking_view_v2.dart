import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/ui/screen/booking/booking_viewmodel.dart';

import '../../../app/routes.dart';

class MakeBookingView extends StatefulWidget {
  const MakeBookingView({Key? key}) : super(key: key);
  static Route route() =>
      MaterialPageRoute(builder: (_) => const MakeBookingView());
  @override
  State<MakeBookingView> createState() => _MakeBookingViewState();
}

class _MakeBookingViewState extends State<MakeBookingView> {
  List<String> vetName=[];
  String choosenName='Choose a name';
  

  @override
  Widget build(BuildContext context) {
    vetName.add(choosenName);
    return Scaffold(
      body: View<BookingViewModel>(
        showProgressIndicator: true,
        builder: (context, viewModel) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: viewModel.listVet.length,
            itemBuilder: (context, index) {
              vetName.add(viewModel.listVet[index].name);
              return GestureDetector(
                onTap: () => {viewModel.selectVet(viewModel.listVet[index])},
                child: Row(children: [
                  Image.asset("assets/cat.png", scale: 10,),
                  const Padding(
                    padding:  EdgeInsets.only(left: 10),
                    child:  Text("Veterinarian Name", style: TextStyle(fontSize: 10),),
                  ),
                  
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                        ": ${viewModel.listVet[index].name}",style:const TextStyle(fontSize: 10)
                         ),
                  ),
                  const SizedBox(height: 15),
                ]),
              );
              // return DropdownButton(
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       choosenName = newValue!;
              //     });
              //   },
              //   items: vetName.map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              // );
            },
          );
        },
      ),
    );
  }
}
