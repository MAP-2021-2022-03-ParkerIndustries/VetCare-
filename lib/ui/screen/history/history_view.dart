import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:vetclinic/app/app.dart';
import 'package:vetclinic/ui/screen/history/history_viewmodel.dart';
import 'package:vetclinic/utils/app_theme.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const HistoryView());
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  String _search = "";
  // DateTime dateTime = DateTime.parse(timestamp.toDate().toString());
 
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _searchBar(),
            _buildHistoryCard(),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      height: 38,
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 8),
      child: TextField(
        onChanged: (value) => setState(() {
              setState(() {
      _search = value;
      print(_search);
    });
        }),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(0),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none),
            hintStyle: const TextStyle(fontSize: 14, color: Colors.black),
            hintText: "Search"),
      ),
    );
  }

  Widget _buildHistoryCard() {
    
    return View<HistoryViewModel>(
      showProgressIndicator: true,
      builder: (context, viewModel) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: viewModel.listHistory.length,
          itemBuilder: (context, index) {
            
                //parse timestamp firebase into formatted string
            DateTime dateTime = DateTime.parse(viewModel.listHistory[index].dateBooking.toDate().toString());
            String formattedDateTime = DateFormat('dd-MM-yyyy').format(dateTime);

            //searching
            bool check1 = "${viewModel.listHistory[index].animal}".toLowerCase().contains(_search.toLowerCase());
            bool check2 = "${viewModel.listHistory[index].doctor}".toLowerCase().contains(_search.toLowerCase());
            bool check3 = "${viewModel.listHistory[index].paymentType}".toLowerCase().contains(_search.toLowerCase());
            bool check4 = formattedDateTime.toLowerCase().contains(_search.toLowerCase());
            if (check1 || check2 || check3 ||check4) {
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
                        child: Row(
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                      "Animal Type"),
                                ),
                                SizedBox(height: 15),
                                     Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                      "Date Booking"),
                                ),
                                SizedBox(height: 15),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                      "Doctor Assigned"),
                                ),
                                SizedBox(height: 15),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                      "Payment Type"),
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
                                  child: Text(
                                      ": $formattedDateTime"),
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
            );}
            else{
              return SizedBox.shrink();
            }
            
          },
        );
      },
    );
  }
}
