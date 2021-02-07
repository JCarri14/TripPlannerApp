class Flight {
  String flightTime;
  int minPrice;
  String airlineName;

  Flight({
    this.flightTime,
    this.minPrice,
    this.airlineName
  });

  factory Flight.fromJson(Map<String, dynamic> jsonFlight, Map<String, dynamic> jsonAirline) {
    return Flight(
        flightTime: jsonFlight['QuoteDateTime'] != null ? jsonFlight['QuoteDateTime'] : "",
        minPrice: jsonFlight['MinPrice'],
        airlineName: jsonAirline != null ? jsonAirline['Name'] : ""
    );
  }

  factory Flight.fromJsonResume(Map<String, dynamic> json) {
    return Flight(
        flightTime: json['flightTime'],
        minPrice: json['minPrice'],
        airlineName: json['airlineName']
    );
  }

  String toJson(){
    return "{"
        '"flightTime": ' + this.flightTime + ","
        '"minPrice": ' + this.minPrice.toString() + ","
        '"airlineName": ' + this.airlineName + ","
        "}";
  }
}