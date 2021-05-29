import "dart:convert";

List<Flight> flightFromJson(String str) =>
  List<Flight>.from(json.decode(str).map((x) => Flight.fromJson(x)));

String flightToJson(List<Flight> data) =>
  json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Flight {
  String flightTime;
  int minPrice;
  String airlineName;

  Flight({
    this.flightTime = "",
    this.minPrice = 0,
    this.airlineName = ""
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
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