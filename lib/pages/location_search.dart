import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner_app/utils/load_fetch_timer.dart';

import '../api/api_response.dart';
import '../widgets/location_item.dart';

import '../blocs/city_bloc.dart';
import '../models/geo/city.dart';

import '../widgets/custom_shape.dart';

import '../providers/trip_provider.dart';

class LocationSearch extends StatefulWidget {
  static const routeName = '/search';
  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  LoadFetchTimer loadFetchTimer = new LoadFetchTimer();
  final dataBloc = new CityBloc();
  bool isOrigin = false;
  TripManager provider;
  int endTime = 0;
  String autocompleteValue;

  Widget _buildResultList(BuildContext context, List<City> items) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(), 
      itemCount: items.length,
      itemBuilder: (context, index) {
        return LocationItem(city: items[index], index: index, onTapHandler: () {
          if (isOrigin) {
            this.provider.saveOriginCity(items[index]);
          } else {
            this.provider.saveDestinationCity(items[index]);
          }
          Navigator.of(context).pop();
        });
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
          List<City> data = snapshot.data.data ?? [];
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

    this.isOrigin = ModalRoute.of(context).settings.arguments;
    this.provider = Provider.of<TripManager>(context);

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
                    autofocus: true,
                    onChanged: (value) {
                      if (value.length > 1) {
                        loadFetchTimer.loadTimer(() => dataBloc.fetchCitiesByPrefix(autocompleteValue, 5));
                        autocompleteValue = value;
                      }
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

  @override
  void dispose() {
    loadFetchTimer.cancelTimer();
    dataBloc.dispose();
    super.dispose();
  }
}