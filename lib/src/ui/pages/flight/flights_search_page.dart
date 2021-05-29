import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//MODELS
import '../../../business_logic/models.dart';

//ROUTES
import "../../../config/routes/routes.dart";

//PROVIDERS
import "../../../business_logic/providers.dart";

//OTHER
import '../../utils/flight_arguments.dart';
import '../../../network/api/api_response.dart';
import '../../widgets/cards/flight_card.dart';

class FlightSearchPage extends StatefulWidget {

  @override
  _FlightSearchPageState createState() => _FlightSearchPageState();
}

class _FlightSearchPageState extends State<FlightSearchPage> {
  final FlightProvider _flightProvider = new FlightProvider();
  TripCreationProvider tripManager;

  @override
  void dispose() {
    _flightProvider.dispose();
    super.dispose();
  }

  void _onFlightReady(BuildContext context, Flight flight, bool isOrigin) {
    if (isOrigin) {
      tripManager.saveDepartureFlight(flight);
      Navigator.of(context).pushNamed(
      flightSearchRoute, 
      arguments: FlightArguments(
            isNewTrip: true,
            isOrigin: false,
          ));
    } else {
      tripManager.saveReturnFlight(flight);
      Navigator.of(context).pushNamed(
        hotelSearchRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final FlightArguments args = (ModalRoute.of(context).settings.arguments as FlightArguments);
    tripManager = Provider.of<TripCreationProvider>(context);

    String orgId;
    String dstId;
    String flightDate;

    if (args.isOrigin) {
      orgId = tripManager.originAirport.airportId;
      dstId = tripManager.destinationAirport.airportId;
      flightDate = tripManager.destinationDate;
    } else {
      orgId = tripManager.destinationAirport.airportId;
      dstId = tripManager.originAirport.airportId;
      flightDate = tripManager.returnDate;
    }
    _flightProvider.fetchFlights(context, orgId, dstId, flightDate);
    
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
              color: Colors.white,
              child: ListTile(
                title: Text((args.isOrigin ? tripManager.originAirport.placeName:tripManager.destinationAirport.placeName) + ' Airport'),
                subtitle: args.isOrigin ? Text('Origin'):Text('Destination'),
                trailing: Icon(args.isOrigin ? Icons.flight_takeoff:Icons.flight_land),
              )
            ),
            SizedBox(height: 16,),
            Expanded(
              child: StreamBuilder(
                stream: _flightProvider.flightListStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Status status = snapshot.data.status as Status;
                    switch (status) {
                      case Status.LOADING:
                        return Text('Loading data...');
                      case Status.COMPLETED:
                        List<Flight> flights = snapshot.data.data ?? [];
                        return ListView.builder(
                          itemCount: flights.length,
                          itemBuilder: (_, i) {
                            return FlightCard(
                              flight: flights[i],
                              destinationAirport: args.isOrigin ? tripManager.destinationAirport : tripManager.originAirport,
                              originAirport: args.isOrigin ? tripManager.originAirport : tripManager.destinationAirport,
                              flightDate: flightDate,
                              onTapHandler: () { 
                                _onFlightReady(context, flights[i], args.isOrigin);
                              },
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