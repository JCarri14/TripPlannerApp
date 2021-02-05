import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/trip_provider.dart';
import '../models/flight/flight.dart';
import '../models/flight/airport.dart';

import '../pages/search/flights_search.dart';
import '../pages/search/flight_arguments.dart';
import '../pages/search/hotel_search.dart';

class FlightCard extends StatelessWidget {

  final Flight flight;
  final bool isOrigin;

  FlightCard({this.flight, this.isOrigin});

  void _onFlightReady(BuildContext context) {
    if (isOrigin) {
      Navigator.of(context).pushNamed(
      FlightSearch.routeName, 
      arguments: FlightArguments(
            isNewTrip: true,
            isOrigin: false,
          ));
    } else {
      Navigator.of(context).pushNamed(
      HotelSearch.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tripData = Provider.of<TripManager>(context);
    String originId = tripData.originAirport.airportId.split("-")[0];
    String dstId = tripData.destinationAirport.airportId.split("-")[0];
    
    if (isOrigin) {
      return InkWell(
          onTap: () { 
            _onFlightReady(context);
          },
          child: PhysicalModel(
            borderRadius: BorderRadius.circular(16),
            color: Colors.transparent,
            shadowColor: Colors.black,
            elevation: 8.0,
            child: Container(
              //height: 180,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(originId, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Container(
                      margin: EdgeInsets.only(left: 4),
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: SizedBox(
                        height: 8, 
                        width: 8, 
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            borderRadius: BorderRadius.circular(10)
                          )
                        )
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(6),
                        child: Transform.rotate(child: Icon(Icons.local_airport), angle: 1.5,)
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 4),
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: SizedBox(
                        height: 8, 
                        width: 8, 
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            borderRadius: BorderRadius.circular(10)
                          )
                        )
                      ),
                    ),
                    Text(dstId, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 100, child: Text(tripData.originAirport.placeName, style: TextStyle(fontSize: 12, color: Colors.grey))),
                    SizedBox(width: 100, child: Text(tripData.destinationAirport.placeName, textAlign: TextAlign.end, style: TextStyle(fontSize: 12, color: Colors.grey))),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(this.flight.flightTime.substring(14,19), style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold)),
                    Expanded(child: Text(tripData.destinationDate, style: TextStyle(fontSize: 16, color: Colors.black54), textAlign: TextAlign.center,),),
                    Text("02:30 PM", style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Icon(Icons.flight_takeoff, color: Colors.blue.shade400)
                    ),
                    SizedBox(width: 16,),
                    Text(this.flight.airlineName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                    Expanded(child: Text(this.flight.minPrice.toString() + " €", textAlign: TextAlign.end, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black54))),
                  ],
                ),
                ],
              )
            ),
          ),
        );
    }
    return InkWell(
      onTap: () { 
        _onFlightReady(context);
      },
      child: PhysicalModel(
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
        shadowColor: Colors.black,
        elevation: 8.0,
        child: Container(
          //height: 180,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(dstId, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Container(
                  margin: EdgeInsets.only(left: 4),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: SizedBox(
                    height: 8, 
                    width: 8, 
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.circular(10)
                      )
                    )
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: Transform.rotate(child: Icon(Icons.local_airport), angle: 1.5,)
                  )
                ),
                Container(
                  margin: EdgeInsets.only(right: 4),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: SizedBox(
                    height: 8, 
                    width: 8, 
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.circular(10)
                      )
                    )
                  ),
                ),
                Text(originId, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 100, child: Text(tripData.destinationAirport.placeName, style: TextStyle(fontSize: 12, color: Colors.grey))),
                SizedBox(width: 100, child: Text(tripData.originAirport.placeName, textAlign: TextAlign.end, style: TextStyle(fontSize: 12, color: Colors.grey))),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(this.flight.flightTime.substring(14,19), style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold)),
                Expanded(child: Text(tripData.returnDate, style: TextStyle(fontSize: 16, color: Colors.black54), textAlign: TextAlign.center,),),
                Text("02:30 PM", style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.flight_takeoff, color: Colors.blue.shade400)
                ),
                SizedBox(width: 16,),
                Text(this.flight.airlineName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                Expanded(child: Text(this.flight.minPrice.toString() + " €", textAlign: TextAlign.end, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black54))),
              ],
            ),
            ],
          )
        ),
      ),
    );
  }
}