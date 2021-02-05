import 'package:flutter/cupertino.dart';

abstract class FlightRepository {
  Future<List<dynamic>> getAirports(BuildContext context, String city);
  Future<List<dynamic>> getFlights(BuildContext context, String origin, String destination, String date);
}