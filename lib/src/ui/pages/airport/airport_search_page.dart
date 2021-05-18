import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

//MODELS
import '../../../business_logic/models.dart';

//ROUTES
import "../../../config/routes/routes.dart";

//OTHER
import '../../utils/flight_arguments.dart';
import '../../../network/api/api_response.dart';

//PROVIDERS
import "../../../business_logic/providers.dart";

class AirportSearchPage extends StatefulWidget {
  static const routeName = '/airport-search';

  AirportSearchPage();

  @override
  _AirportSearchPageState createState() => _AirportSearchPageState();
}

class _AirportSearchPageState extends State<AirportSearchPage> {
  final AirportProvider _airportOrgBloc = new AirportProvider();
  final AirportProvider _airportDstBloc = new AirportProvider();
  TripCreationProvider tripManager;

  @override
  void dispose() {
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
      airportSearchRoute, 
      arguments: FlightArguments(
            isNewTrip: true,
            isOrigin: false,
          ));
    } else {
      Navigator.of(context).pushNamed(
      flightSearchRoute, 
      arguments: FlightArguments(
            isNewTrip: true,
            isOrigin: true,
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    tripManager = Provider.of<TripCreationProvider>(context);
    FlightArguments args = ModalRoute.of(context).settings.arguments;
    
    if (args.isOrigin) {
        _airportOrgBloc.fetchAirports(context, tripManager.originCity.name, tripManager.originCity.country);
    } else {
      _airportDstBloc.fetchAirports(context, tripManager.destinationCity.name, tripManager.destinationCity.country);
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
              child: ElevatedButton(
                    onPressed: () {
                      onAirportReady(context, args.isOrigin);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor
                    ),
                    child: Text("Continuar")),
              ),   
          ],
          ),
        ),
      ),
    );
  }
}