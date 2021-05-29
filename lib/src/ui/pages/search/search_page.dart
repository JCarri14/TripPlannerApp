import 'package:flutter/material.dart';

import './search_bar.dart';
// import '../../widgets/location_item.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<String> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: SearchInput(
          onChanged: (value) {
            if (value != '') {
              // TODO: Call getItems...
              //dataBloc.fetchCities();
              print(value);
            }
          },
        ),
      ),
      body: Container(
      ),
    );
  }
}