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
      
      for(int i = 0; i < json['Quotes'].length && i < 2; i++){
        int carrierId = json['Quotes'][i]['OutboundLeg']['CarrierIds'][0];
        var carrier;
        for (int j = 0; j < json['Carriers'].length; j++) { 
          if (json['Carriers'][i]['CarrierId'] == carrierId) {
            print(carrierId);
            carrier = json['Carriers'][i];
          }
        }
        
        items.add(parseItem(type, json['Quotes'][i], carrier));
        print("Hola");
      }
    } else {
      items = new List<Airport>();
      for (int i = 0; i < json['Places'].length; i++) {
        items.add(parseItem(type, json['Places'][i], null));
      }
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