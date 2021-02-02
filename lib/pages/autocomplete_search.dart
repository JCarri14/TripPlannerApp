import 'package:flutter/material.dart';

import '../api/api_response.dart';
import '../widgets/search_bar.dart';
import '../widgets/location_list.dart';
import '../blocs/text_bloc.dart';

class AutoCompleteSearch extends StatefulWidget {
  @override
  _AutoCompleteSearchState createState() => _AutoCompleteSearchState();
}

class _AutoCompleteSearchState extends State<AutoCompleteSearch> {

  final dataBloc = new TextBloc();
  List<String> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {}),
        title: SearchInput(
          onChanged: (value) {
            if (value != '') {
              // TODO: Call getItems...
              dataBloc.fetchCities();
              print(value);
            }
          },
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: dataBloc.cityListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                    return Container(
                child: Center(
                  child: Text("Loading data"),
                )
              );
                case Status.COMPLETED:
                  data = snapshot.data.data ?? [];
                  return LocationList(items: data);
                case Status.ERROR:
                  return Container(
                    child: Center(
                      child: Text("No data received"),
                    )
                  ); 
              }   
            } else {
              return Container(
                child: Center(
                  child: Text("No data received"),
                )
              );
            }            
          }
        ),
      ),
    );
  }
}