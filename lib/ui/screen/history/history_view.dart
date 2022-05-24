import 'package:flutter/material.dart';

class HistoryView extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const HistoryView());
  const HistoryView({ Key? key }) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("history"),
    );
  }
}