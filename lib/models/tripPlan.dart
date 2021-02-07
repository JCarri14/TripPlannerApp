import 'package:trip_planner_app/models/flight/airport.dart';
import 'package:trip_planner_app/models/flight/flight.dart';
import 'package:trip_planner_app/models/hotel/hotel.dart';
import 'package:trip_planner_app/models/tourDay.dart';
class TripPlan {
  Airport originAirport;
  Airport destinationAirport;
  Flight departureFlight;
  Flight returnFlight;
  Hotel hotel;
  List<TourDay> tourDaysList;

  TripPlan({this.originAirport,
  this.destinationAirport,
  this.departureFlight,
  this.returnFlight,
  this.hotel,
  this.tourDaysList});

  void addTourDay(TourDay tourDay){
    if(tourDaysList == null){
      tourDaysList = new List<TourDay>();
    }
    tourDaysList.add(tourDay);
  }

  factory TripPlan.fromJsonResume(Map<String, dynamic> json){
    TripPlan tripPlan =  TripPlan(originAirport: Airport.fromJsonResume(json['originAirport']),
        destinationAirport: Airport.fromJsonResume(json['destinationAirport']),
        departureFlight: Flight.fromJsonResume(json['departureFlight']),
        returnFlight: Flight.fromJsonResume(json['returnFlight']),
        hotel: Hotel.fromJsonResume(json['hotel']),
        tourDaysList: new List<TourDay>());

    for(Map<String, dynamic> tourDay in json['tourDaysList']) {
      tripPlan.tourDaysList.add(TourDay.fromJsonResume(tourDay));
    }
    return tripPlan;
  }

  String toJson(){
    String tourDaysJson = '{ "tourDaysList": [';
    for(TourDay tourDay in this.tourDaysList){
      tourDaysJson += tourDay.toJson() + ", ";
    }
    tourDaysJson += "] }";

    return "{"
        '"originAirport": ' + this.originAirport.toJson() + ","
        '"destinationAirport": ' + this.destinationAirport.toJson() + ","
        '"departureFlight": ' + this.departureFlight.toJson() + ","
        '"returnFlight": ' + this.returnFlight.toJson() + ","
        '"hotel": ' + this.hotel.toJson() + ","
        '"tourDaysList": ' + tourDaysJson + ","
        "}";
  }
}
