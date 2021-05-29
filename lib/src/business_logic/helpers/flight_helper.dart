import '../models.dart';

List<Airport> normalizeAirports(Map<String, dynamic> json,) {
  List<Airport> airports = <Airport>[];
  if (json['Places'] != null) {
    for (int i = 0; i < json['Places'].length; i++) {
      airports.add(parseAirport(json['Places'][i]));
    }
  }
  return airports;
}

Airport parseAirport(Map<String, dynamic> json) {
  return Airport(
    airportId: json['PlaceId'],
    cityId: json['CityId'],
    placeName: json['PlaceName'],
    countryName: json['CountryName']
  );
}

List<Flight> normalizeFlights(Map<String, dynamic> json) {
  List<Flight> flights = <Flight>[];
  if (json['Quotes'] != null) {
    for(int i = 0; i < json['Quotes'].length; i++){
      int carrierId = json['Quotes'][i]['OutboundLeg']['CarrierIds'][0];
      var carrier;
      for (int j = 0; j < json['Carriers'].length; j++) { 
        if (json['Carriers'][i]['CarrierId'] == carrierId) {
          carrier = json['Carriers'][i];
        }
      }
      flights.add(parseFlight(json['Quotes'][i], carrier));
    }
  }
  return flights;
}

Flight parseFlight(Map<String, dynamic> jsonFlight, Map<String, dynamic> jsonAirline) {
  return Flight(
    flightTime: jsonFlight['QuoteDateTime'] != null ? jsonFlight['QuoteDateTime'] : "",
    minPrice: jsonFlight['MinPrice'],
    airlineName: jsonAirline != null ? jsonAirline['Name'] : ""
  );
}

