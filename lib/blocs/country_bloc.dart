import 'dart:async';

import 'package:trip_planner_app/models/geo/geo.dart';

import '../api/api_response.dart';
import '../models/geo/city.dart';
import '../models/geo/region.dart';
import '../models/geo/country.dart';
import '../services/geo_service.dart';

class CountryBloc {
  GeoService _geoService;

  StreamController _countryListController;

  StreamSink<ApiResponse<List<Country>>> get countryListSink =>
    _countryListController.sink;

  Stream<ApiResponse<List<Country>>> get countryListStream =>
    _countryListController.stream;

  GeoBloc() {
    _countryListController = StreamController<ApiResponse<List<Country>>>();
    _geoService = GeoService();
  }

  fetchCountries(int offset) async {
    countryListSink.add(ApiResponse.loading('Fetching Countries'));
    try {
      List<Country> countries = await _geoService.getAll(GeoType.COUNTRY, offset);
      countryListSink.add(ApiResponse.completed(countries));
    } catch (e) {
      countryListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }


  dispose() {
    _countryListController?.close();
  }
}