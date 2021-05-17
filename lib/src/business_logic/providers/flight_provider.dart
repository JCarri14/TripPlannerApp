
import 'dart:async';
import 'package:flutter/material.dart';

// SERVICE
import "../../network/services.dart";
import "../../network/api/api_response.dart";

// MODELS
import '../models.dart';

// Used as StreamProvider
class FlightProvider {
  late final FlightService _flightService;
  late StreamController<ApiResponse<List<Flight>>> _listController;

  StreamSink<ApiResponse<List<Flight>>> get flightListSink =>
      _listController.sink;

  Stream<ApiResponse<List<Flight>>>? get flightListStream =>
      _listController.stream;

  FlightProvider() {
    _flightService = FlightService();
    _listController = StreamController<ApiResponse<List<Flight>>>();
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
    _listController.close();
  }
}