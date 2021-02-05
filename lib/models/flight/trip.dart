import './airport.dart';
import './flight.dart';

class Trip {
  final Flight flight;
  final Airport originAirport;
  final Airport destinationAirport;
  
  Trip({this.flight,
  this.originAirport,
  this.destinationAirport});

}
