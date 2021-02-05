import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner_app/blocs/flight_bloc.dart';
import 'package:trip_planner_app/pages/maps_page.dart';
import 'package:trip_planner_app/pages/search/flight_arguments.dart';

import '../../api/api_response.dart';
import '../../blocs/flight_bloc.dart';
import '../../providers/trip_provider.dart';

import '../../api/api_response.dart';
import '../../widgets/flight_card.dart';
import '../../models/flight/airport.dart';
import '../../models/flight/flight.dart';
import '../../widgets/card_item.dart';

class FlightSearch extends StatefulWidget {
  static const routeName = '/flight-search';

  FlightSearch();

  @override
  _FlightSearchState createState() => _FlightSearchState();
}

class _FlightSearchState extends State<FlightSearch> {
  final FlightBloc _flightOrgBloc = new FlightBloc();
  TripManager tripManager;


  @override
  void dispose() {
    // TODO: implement dispose
    _flightOrgBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FlightArguments args = ModalRoute.of(context).settings.arguments;
    tripManager = Provider.of<TripManager>(context);

    String org = tripManager.originAirport.airportId;
    String dst = tripManager.destinationAirport.airportId;
    if (args.isOrigin) {
      String orgDate = tripManager.destinationDate;
      _flightOrgBloc.fetchFlights(context, org, dst, orgDate);
    } else {
      String dstDate = tripManager.returnDate;
      _flightOrgBloc.fetchFlights(context, dst, org, dstDate);
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Selection'),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            SizedBox(height: 8,),
            Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(8),
              child: ListTile(
                title: Text(args.isOrigin ? tripManager.originAirport.placeName:tripManager.destinationAirport.placeName + ' Airport'),
                subtitle: args.isOrigin ? Text('Origin'):Text('Destination'),
                trailing: Icon(args.isOrigin ? Icons.flight_takeoff:Icons.flight_land),
              )
            ),
            SizedBox(height: 16,),
            Expanded(
              child: StreamBuilder(
                stream: _flightOrgBloc.flightListStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        return Text('Loading data...');
                      case Status.COMPLETED:
                        List<Flight> flights = snapshot.data.data ?? [];
                        return ListView.builder(
                          itemCount: flights.length,
                          itemBuilder: (_, i) {
                            return FlightCard(
                              flight: flights[i],
                              isOrigin: args.isOrigin
                            );
                          },
                        );
                      case Status.ERROR:
                        return Text('Error while fetching...');
                    }
                  }
                  return Container(
                    child: Center(
                      child: Text("No data received"),
                    )
                  );
                },),
            ),
          ],),
        ),
      ),
    );
  }
}