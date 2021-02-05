import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:trip_planner_app/blocs/flight_bloc.dart';
import 'package:trip_planner_app/pages/search/flight_arguments.dart';

import '../../blocs/airport_bloc.dart';
import '../../providers/trip_provider.dart';

import '../../api/api_response.dart';
import '../../pages/search/flights_search.dart';
import '../../widgets/flight_card.dart';
import '../../models/flight/airport.dart';


class AirportSearch extends StatefulWidget {
  static const routeName = '/airport-search';

  AirportSearch();

  @override
  _AirportSearchState createState() => _AirportSearchState();
}

class _AirportSearchState extends State<AirportSearch> {
  final AirportBloc _airportOrgBloc = new AirportBloc();
  final AirportBloc _airportDstBloc = new AirportBloc();
  TripManager tripManager;

  @override
  void dispose() {
    // TODO: implement dispose
    _airportOrgBloc.dispose();
    _airportDstBloc.dispose();
    super.dispose();
  }

  Widget _buildStreamBuilder(BuildContext ctx, bool isOrigin) {
    return StreamBuilder(
          stream: isOrigin ? _airportOrgBloc.airportListStream: _airportDstBloc.airportListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                return Container(
                  child: Center(
                    child: Lottie.asset("assets/circle-loader.json"),
                  )
                );
                case Status.COMPLETED:
                List<Airport> ap = snapshot.data.data ?? [];
                return Container(
                  width: double.infinity,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: ap.length,
                    itemBuilder: (_, index) {
                    String loc = ap[index].placeName + ', ' + ap[index].countryName;
                    return InkWell(
                      onTap: () {
                        if (isOrigin) {
                          tripManager.saveOriginAirport(ap[index]);
                        } else {
                          tripManager.saveDestinationAirport(ap[index]);
                        }
                        onAirportReady(ctx, isOrigin);
                      },
                      child: ListTile(
                        title: Text(ap[index].airportId),
                        subtitle: Text(loc),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      )
                    );
                  },)
                );
              }
            }
            return Container();
          },
    );
  }

  void onAirportReady(BuildContext context, bool isOrigin) {
    if (isOrigin) {
      Navigator.of(context).pushNamed(
      AirportSearch.routeName, 
      arguments: FlightArguments(
            isNewTrip: true,
            isOrigin: false,
          ));
    } else {
      Navigator.of(context).pushNamed(
      FlightSearch.routeName, 
      arguments: FlightArguments(
            isNewTrip: true,
            isOrigin: true,
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    tripManager = Provider.of<TripManager>(context);
    FlightArguments args = ModalRoute.of(context).settings.arguments;
    
    if (args.isOrigin) {
        _airportOrgBloc.fetchAirports(context, tripManager.originCity.name);
    } else {
      _airportDstBloc.fetchAirports(context, tripManager.destinationCity.name);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Airport Selection'),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            SizedBox(height: 8,),
            Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(8),
              child: ListTile(
                title: Text(args.isOrigin ? 'Origin Airport':'Destination Airport'),
                trailing: Icon(args.isOrigin ? Icons.flight_takeoff:Icons.flight_land),
              )
            ),
            SizedBox(height: 16,),
            Expanded(
              child: _buildStreamBuilder(context, args.isOrigin)
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: RaisedButton(
                    onPressed: () {
                      onAirportReady(context, args.isOrigin);
                    },
                    color: Colors.blue,
                    child: Text("Continuar")),
              ),   
          ],
          ),
        ),
      ),
    );
  }
}