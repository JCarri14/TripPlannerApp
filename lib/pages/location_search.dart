import 'package:flutter/material.dart';

import '../api/api_response.dart';
import '../widgets/location_item.dart';
import '../blocs/text_bloc.dart';
import '../widgets/custom_shape.dart';

class LocationSearch extends StatefulWidget {
  static const routeName = '/search';
  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {

  final dataBloc = new TextBloc();
  List<String> data = [];

  Widget _buildResultList(BuildContext context, List<Object> items) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(), 
      itemCount: items.length,
      itemBuilder: (context, index) {
        return LocationItem(city: items[index], index: index, onTapHandler: () {});
      },
    );
  }

  Widget _buildStreamBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
          return _buildResultList(context, data);
        case Status.ERROR:
          return Container(
            child: Align(
              alignment: Alignment.centerLeft,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Location'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(children: [
           Stack(children: [
              ClipPath(
                clipper: CustomShapeClipper(),
                child: Container(
                  height: 160.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.blue.shade400, Colors.blue])
                  ),
                ),
              ),
              Column(children: [
                SizedBox(height: 30,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: TextField(
                    onChanged: (value) {
                      dataBloc.fetchCities();
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter a city...',
                      border: InputBorder.none
                    ),
                  )
                ),
              ]),
          ]),
          Align(
            alignment: Alignment.center,
            child: Text('Results', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          SizedBox(height: 4),
          Expanded(
            child: StreamBuilder(
              stream: dataBloc.cityListStream,
              builder: (context, snapshot) => _buildStreamBuilder(context, snapshot) 
            ),
          ),
        ]
        ),
      ),
    );
  }
}