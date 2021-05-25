import '../../models.dart';

class Trip {
  DateTime destinationDay;
  DateTime returnDay;
  City originCity;
  City destinationCity;
  Airport originAirport;
  Airport destinationAirport;
  Flight departureFlight;
  Flight returnFlight;
  Hotel hotel;
  List<Event> events;
  int numAdults;
  int numTeens;

  Trip(): 
  destinationDay = DateTime.now(),
  returnDay = DateTime.now(),
  originCity = City(),
  destinationCity = City(),
  originAirport = Airport(), 
  destinationAirport = Airport(), 
  departureFlight =  Flight(),
  returnFlight = Flight(),
  hotel = Hotel(),
  events = [],
  numAdults = 0,
  numTeens = 0;

  void addEvent(Event event) {
    if (events == null) events = [];
    events.add(event);
  }

  void removeEvent(String id) {
    events.removeWhere((e) => e.id == id);
  }

  factory Trip.fromJson(Map<String, dynamic> json){
    Trip trip =  Trip();
    trip.originAirport = Airport.fromJson(json['originAirport']);
    trip.destinationAirport = Airport.fromJson(json['destinationAirport']);
    trip.departureFlight = Flight.fromJson(json['departureFlight']);
    trip.returnFlight = Flight.fromJson(json['returnFlight']);
    trip.hotel = Hotel.fromJson(json['hotel']);
    trip.events = [];

    for(Map<String, dynamic> event in json['events']) {
      trip.events.add(Event.fromJson(event));
    }
    return trip;
  }

  String toJson(){
    String eventsJson = '[';
    for(Event event in this.events){
      eventsJson += event.toJson() + ", ";
    }
    eventsJson += "],";

    return "{"
      '"destinationDay": ' + this.destinationDay.toString() + ","
      '"returnDay": ' + this.returnDay.toString() + ","
      '"originCity": ' + this.originCity.toJson() + ","
      '"destinationCity": ' + this.destinationCity.toJson() + ","
      '"originAirport": ' + this.originAirport.toJson() + ","
      '"destinationAirport": ' + this.destinationAirport.toJson() + ","
      '"departureFlight": ' + this.departureFlight.toJson() + ","
      '"returnFlight": ' + this.returnFlight.toJson() + ","
      '"hotel": ' + this.hotel.toJson() + ","
      '"numAdults": ' + this.numAdults.toString() + ","
      '"numTeens": ' + this.numTeens.toString() + ","
      '"events": ' + eventsJson + ","
      "}";
  }
}