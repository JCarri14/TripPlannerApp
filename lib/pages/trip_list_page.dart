import 'package:flutter/material.dart';
import '../widgets/trip_item.dart';
import '../blocs/city_bloc.dart';
import '../api/api_response.dart';
import '../models/geo/city.dart';

class TripListPage extends StatelessWidget {

  final _citiesBloc = new CityBloc();

  @override
  Widget build(BuildContext context) {
    _citiesBloc.fetchCities(10);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder(
        stream: _citiesBloc.cityListStream,
        builder: ( context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Text('Loading data...');
              case Status.COMPLETED:
                final List<City> cities = snapshot.data.data ?? [];
                return ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (_, i) {
                    return ListTile(
                      title: Text(cities[i].name),
                    );
                  },
                );
              case Status.ERROR:
                return Text('Error while fetching...');
            }
          }
          return Container();
        }
      ),
    );
  }
}

/*
@override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (ctx, i) => TripItem(),
      ),
    );
  }
*/