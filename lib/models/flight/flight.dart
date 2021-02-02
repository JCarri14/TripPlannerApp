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
      flightTime: jsonFlight['QuoteDateTime'].substring(-8),
      minPrice: jsonFlight['MinPrice'],
      airlineName: jsonAirline['Name']
    );
  }
}