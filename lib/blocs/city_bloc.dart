import 'dart:async';

import 'package:trip_planner_app/models/geo/geo.dart';

import '../api/api_response.dart';
import '../models/geo/city.dart';
import '../services/geo_service.dart';

class CityBloc {
  GeoService _geoService;
  
  StreamController _cityListController;

  // Objecte que accepta events
  StreamSink<ApiResponse<List<City>>> get cityListSink =>
    _cityListController.sink;

  Stream<ApiResponse<List<City>>> get cityListStream =>
    _cityListController.stream;


  CityBloc() {
    _cityListController = StreamController<ApiResponse<List<City>>>();
    _geoService = GeoService();
  }

  fetchCities(int offset) async {
    cityListSink.add(ApiResponse.loading('Fetching Cities'));
    try {
      List<City> cities = await _geoService.getAll(GeoType.CITY, offset);
      cityListSink.add(ApiResponse.completed(cities));
    } catch (e) {
      cityListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchCitiesByRegion(String countryId, String regionId, int offset) async {
    cityListSink.add(ApiResponse.loading('Fetching Cities'));
    try {
      List<City> cities = await _geoService.getCitiesByRegion(countryId, regionId, offset);
      cityListSink.add(ApiResponse.completed(cities));
    } catch (e) {
      cityListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }


  dispose() {
    _cityListController?.close();
  }
}