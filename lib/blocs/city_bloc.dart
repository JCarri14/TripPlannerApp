import 'dart:async';

import 'package:trip_planner_app/models/geo/geoResponse.dart';

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

  fetchCitiesByPrefix(String prefix, int offset) async {
    cityListSink.add(ApiResponse.loading('Fetching Cities'));
    try {
      List<City> cities = await _geoService.getByPrefix(GeoType.CITY, prefix, offset);
      cityListSink.add(ApiResponse.completed(cities));
    } catch (e) {
      cityListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchCitiesByProximity(int offset) async {
    cityListSink.add(ApiResponse.loading('Fetching Cities'));
    try {
      List<City> cities = await _geoService.getByProximity(GeoType.CITY, offset);
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