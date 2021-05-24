import "package:flutter/material.dart";
import 'package:provider/provider.dart';

//WIDGETS
import "../../widgets/containers/base_scrollable_container.dart";
import "./trip_events_carousel.dart";

//PROVIDERS
import "../../../business_logic/providers.dart";

//MODELS
import "../../../business_logic/models.dart";

//ROUTES
import "../../../config/routes/routes.dart";

class TripPageArguments {
  final Trip trip;
  final bool saveMode;

  TripPageArguments({this.trip, this.saveMode});
}

class TripPage extends StatefulWidget {

  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  AppProvider appProvider;

  @override
  Widget build(BuildContext context) {  
    appProvider = Provider.of<AppProvider>(context);

    final args = ModalRoute.of(context).settings.arguments as TripPageArguments;
    print(args.trip.toJson());

    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text("Trip Page"),
      ),
      body: BaseScrollableContainer(
        child: Column(
          children: [
            SizedBox(height: 16,),
            Card(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    width: double.infinity,
                    child: Text(
                      "Origin", 
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),                 
                  ListTile(
                    title: Text("City"),
                    subtitle: Text(args.trip.originCity.toString()),
                  ),
                  ListTile(
                    title: Text("Airport"),
                    subtitle: Text(args.trip.originAirport.placeName),
                  ),
                  ListTile(
                    title: Text("Flight Ticket"),
                    subtitle: Row(
                      children: [
                        Text(args.trip.departureFlight.airlineName),
                        SizedBox(width: 8),
                        Text(args.trip.departureFlight.minPrice.toString() + " €", textAlign: TextAlign.end, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black54)),
                      ]
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Card(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    width: double.infinity,
                    child: Text(
                      "Destination", 
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ), 
                  ListTile(
                    title: Text("City"),
                    subtitle: Text(args.trip.destinationCity.toString()),
                  ),
                  ListTile(
                    title: Text("Airport"),
                    subtitle: Text(args.trip.destinationAirport.placeName),
                  ),
                  ListTile(
                    title: Text("Flight Ticket"),
                    subtitle: Row(
                      children: [
                        Text(args.trip.returnFlight.airlineName),
                        SizedBox(width: 8),
                        Text(args.trip.returnFlight.minPrice.toString() + " €", textAlign: TextAlign.end, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black54)),
                      ]
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              width: double.infinity,
              child: Text(
                "Events", 
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
            TripEventsCarousel(),
            SizedBox(height: 16,),
            args.saveMode ? 
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                autofocus: false,
                clipBehavior: Clip.none,
                child: Text("Continue"),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor
                ),
                onPressed: () {
                  appProvider.addTrip(args.trip);
                  Navigator.of(context).popAndPushNamed(
                    homeRoute);
                },
              )
            ):
            Container(),
            SizedBox(height: 16,),
          ]
        ),
      ),
    );
  }
}