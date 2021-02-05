import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:trip_planner_app/api/api_response.dart';
import 'package:trip_planner_app/models/flight/flight.dart';
import 'package:trip_planner_app/services/flight_service.dart';

class FlightBloc {
  FlightService _flightService;
  StreamController _flightListController;

  // Objecte que accepta events
  StreamSink<ApiResponse<List<Flight>>> get flightListSink =>
      _flightListController.sink;

  Stream<ApiResponse<List<Flight>>> get flightListStream =>
      _flightListController.stream;


  FlightBloc() {
    _flightListController = StreamController<ApiResponse<List<Flight>>>();
    _flightService = FlightService();
  }

  fetchFlights(BuildContext context, String origin, String destination, String date) async {
    flightListSink.add(ApiResponse.loading('Fetching Flights'));
    try {
      List<Flight> flights = await _flightService.getFlights(context, origin, destination, date);
      flightListSink.add(ApiResponse.completed(flights));
    } catch (e) {
      flightListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _flightListController?.close();
  }
}