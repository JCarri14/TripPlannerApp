import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  
  final ValueChanged<String> onChanged;

  SearchInput({required this.onChanged}): super();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "Enter location...",
          //suffixIcon: Icon(Icons.search, color: Colors.white),
        ),
        style: TextStyle(
          fontSize: 18
        ),
      ),
    );
  }
}