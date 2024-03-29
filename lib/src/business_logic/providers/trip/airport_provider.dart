import 'dart:async';
import 'package:flutter/material.dart';

//SERVICE
import '../../../network/services.dart';
import '../../../network/api/api_response.dart';

//MODELS
import '../../models.dart';

class AirportProvider {
  FlightService _airportService;
  StreamController _airportListController;

  // Objecte que accepta events
  StreamSink<ApiResponse<List<Airport>>> get airportListSink =>
      _airportListController.sink;

  Stream<ApiResponse<List<Airport>>> get airportListStream =>
      _airportListController.stream;


  AirportProvider() {
    _airportListController = StreamController<ApiResponse<List<Airport>>>();
    _airportService = FlightService();
  }

  fetchAirports(BuildContext context, String cityName, String countryName) async {
    airportListSink.add(ApiResponse.loading('Fetching Airports'));
    try {
      // Devuelve solo un aeropuerto
      List<Airport> airports = await _airportService.getAirports(context, cityName, countryName);
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