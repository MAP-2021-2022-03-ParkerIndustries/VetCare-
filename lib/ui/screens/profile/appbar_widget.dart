import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context){
  return AppBar(
    leading: BackButton(),
    backgroundColor: Colors.red,
    elevation: 0, //remove shadow
  );
}