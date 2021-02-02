import 'dart:async';

import 'package:trip_planner_app/models/geo/geo.dart';

import '../api/api_response.dart';
import '../models/geo/city.dart';
import '../models/geo/region.dart';
import '../models/geo/country.dart';
import '../services/geo_service.dart';

class RegionBloc {
  GeoService _geoService;
  
  StreamController _regionListController;

  StreamSink<ApiResponse<List<Region>>> get regionListSink =>
    _regionListController.sink;

  Stream<ApiResponse<List<Region>>> get regionListStream =>
    _regionListController.stream;

  RegionBloc() {
    _regionListController = StreamController<ApiResponse<List<Region>>>();
    _geoService = GeoService();
  }

  fetchRegions(String countryId, int offset) async {
    regionListSink.add(ApiResponse.loading('Fetching Regions'));
    try {
      List<Region> regions = await _geoService.getRegionsByCountry(countryId, offset);
      regionListSink.add(ApiResponse.completed(regions));
    } catch (e) {
      regionListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _regionListController?.close();
  }
}