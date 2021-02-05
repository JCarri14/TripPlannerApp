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
      if (json['Quotes'] != null) {
        for(int i = 0; i < json['Quotes'].length && i < 2; i++){
          int carrierId = json['Quotes'][i]['OutboundLeg']['CarrierIds'];
          var carrier;
          for (int j = 0; j < json['Carriers'].length; j++) { 
            if (json['Carriers'][i]['CarrierId'] == carrierId) {
              carrier = json['Carriers'][i];
            }
          }        
          items.add(parseItem(type, json['Quotes'][i], carrier));
        }
      }
    } else {
      items = new List<Airport>();
      if (json['Places'] != null) {
        for (int i = 0; i < json['Places'].length; i++) {
          items.add(parseItem(type, json['Places'][i], null));
        }
        
      }
      
    }
  }

  dynamic parseItem(FlightType type, dynamic json, dynamic extraParameters) {
    print(type);
    switch(type) {
      case FlightType.AIRPORT:
        return Airport.fromJson(json);
      default:
        return Flight.fromJson(json, extraParameters);
    }
  }
}