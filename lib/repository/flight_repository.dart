import '../models/airport.dart';

abstract class FlightRepository {
  Future<List<Airport>> getAirports();
  Future<List<dynamic>> getFlights();
}