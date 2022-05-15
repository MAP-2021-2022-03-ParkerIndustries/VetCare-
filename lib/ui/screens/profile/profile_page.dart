import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vetclinic/ui/screens/profile/profile_widget.dart';
import 'appbar_widget.dart';

class ProfilePage extends StatefulWidget{
  @override
  _ProfilePageState createState() =>_ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:buildAppBar (context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            onClicked: () async{},
          ),
          const SizedBox(height:24),
          //buildName(user),
        ],
      ),
    );
  }
}