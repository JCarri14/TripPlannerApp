import 'dart:async';

import 'package:trip_planner_app/models/geo/cityThumbnail.dart';
import 'package:trip_planner_app/models/geo/geoResponse.dart';
import 'package:trip_planner_app/services/city_thumbnail_service.dart';

import '../api/api_response.dart';
import '../models/geo/city.dart';
import '../services/geo_service.dart';

class CityThumbnailBloc {
  CityThumbnailService _cityThumbnailService;
  StreamController _cityThumbnailController;

  // Objecte que accepta events
  StreamSink<ApiResponse<CityThumbnail>> get cityThumbnailSink =>
      _cityThumbnailController.sink;

  Stream<ApiResponse<CityThumbnail>> get cityThumbnailStream =>
      _cityThumbnailController.stream;


  CityThumbnailBloc() {
    _cityThumbnailController = StreamController<ApiResponse<CityThumbnail>>();
    _cityThumbnailService = CityThumbnailService();
  }

  fetchCityThumbnails(String cityName) async {
    cityThumbnailSink.add(ApiResponse.loading('Fetching City Thumbnails'));
    try {
      CityThumbnail cityThumbnail = await _cityThumbnailService.getByCityName(cityName);
      cityThumbnailSink.add(ApiResponse.completed(cityThumbnail));
    } catch (e) {
      cityThumbnailSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }


  dispose() {
    _cityThumbnailController?.close();
  }
}