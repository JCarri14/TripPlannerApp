import './flight.dart';
import './airport.dart';

enum FlightType {AIRPORT, ROUTE}

class FlightResponse {
  List<dynamic> items;
  int totalItems;
  String nextUrl;

  FlightResponse.fromJson(Map<String, dynamic> json, FlightType type) {
    if (type == FlightType.ROUTE) {
      items = new List<Flight>();

      for(int i = 0; i < 2; i++){
        items.add(parseItem(type, json['Quotes'][i], json['Carriers'][i]));
      }
    } else {
      items = new List<Airport>();

      items.add(parseItem(type, json['Places'][0], null));
    }
  }

  dynamic parseItem(FlightType type, dynamic json, dynamic extraParameters) {
    switch(type) {
      case FlightType.AIRPORT:
        return Airport.fromJson(json);
      default:
        return Flight.fromJson(json, extraParameters);
    }
  }
}