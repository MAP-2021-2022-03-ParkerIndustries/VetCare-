import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    String search = "";
  
    return Container(
      height: 38,
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 8),
      child: TextField(
        onChanged: (value) => setState(() {
          search = value;
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
}
