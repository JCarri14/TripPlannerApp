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

}
