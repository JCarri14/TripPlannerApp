import 'package:trip_planner_app/models/flight/trip.dart';
import 'package:trip_planner_app/models/hotel/hotel.dart';
import 'package:trip_planner_app/models/tourDay.dart';
class TripPlan {
  final Trip departureTrip;
  final Trip returnTrip;
  final Hotel hotel;
  final List<TourDay> tourDaysList;

  TripPlan({this.departureTrip,
  this.returnTrip,
  this.hotel,
  this.tourDaysList});

}
