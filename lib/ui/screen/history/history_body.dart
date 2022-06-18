import 'package:flutter/material.dart';
import 'package:vetclinic/ui/components/search_bar.dart';

import 'history_card.dart';

class HistoryBody extends StatefulWidget {
  const HistoryBody({Key? key}) : super(key: key);

  @override
  State<HistoryBody> createState() => _HistoryBodyState();
}

class _HistoryBodyState extends State<HistoryBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: const [
        SearchBar(),
        HistoryCard(),
      ],
    ));
  }
}
