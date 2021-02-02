import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:trip_planner_app/api/api_response.dart';
import 'package:trip_planner_app/models/flight/airport.dart';
import 'package:trip_planner_app/services/flight_service.dart';

class AirportBloc {
  FlightService _airportService;
  StreamController _airportListController;

  // Objecte que accepta events
  StreamSink<ApiResponse<List<Airport>>> get airportListSink =>
      _airportListController.sink;

  Stream<ApiResponse<List<Airport>>> get airportListStream =>
      _airportListController.stream;


  FlightBloc() {
    _airportListController = StreamController<ApiResponse<List<Airport>>>();
    _airportService = FlightService();
  }

  fetchCities(BuildContext context, String cityName) async {
    airportListSink.add(ApiResponse.loading('Fetching Flights'));
    try {
      // Devuelve solo un aeropuerto
      List<Airport> airports = await _airportService.getAirports(context, cityName);
      airportListSink.add(ApiResponse.completed(airports));
    } catch (e) {
      airportListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _airportListController?.close();
  }
}