import 'package:trip_planner_app/models/flight/trip.dart';
import 'package:trip_planner_app/models/hotel/hotel.dart';
class TripPlan {
  final Trip departureTrip;
  final Trip returnTrip;
  final Hotel hotel;

  TripPlan({this.departureTrip,
  this.returnTrip,
  this.hotel});

}
