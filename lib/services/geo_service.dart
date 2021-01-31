import 'dart:core';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../api/api_provider.dart';
import '../repository/geo_repository.dart';

import '../models/geo/city.dart';
import '../models/geo/region.dart';
import '../models/geo/geo.dart';

class GeoService implements GeoRepository {
  static const String _baseUrl = "wft-geo-db.p.rapidapi.com";
  static const int fetchLimit = 5;
  String _pathUrl;
  Map<String, String> _headers;
  ApiProvider _service = ApiProvider();

  GeoService() {
    _headers = {
       'x-rapidapi-key': env['API_KEY'],
       'x-rapidapi-host': env['API_HOST_GEO'],
       'useQueryString': 'true'
    };
  }

  Uri _createUri(Map<String, String> queryParams) {
    if (queryParams != null ) {
      return Uri.https(_baseUrl, _pathUrl, queryParams);
    }
    return Uri.https(_baseUrl, _pathUrl);
  }

  void _updatePath(GeoType type) {
    switch (type) {
      case GeoType.CITY:
        _pathUrl = "/v1/geo/cities";
        break;
      case GeoType.COUNTRY:
        _pathUrl = "/v1/geo/countries";
        break;
    }
  }

  @override
  Future<List<dynamic>> getAll(GeoType type, int offset) async {
    _updatePath(type);
    Map<String, String> queryParams = { 'offset': (fetchLimit*offset).toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    return GeoResponse.fromJson(response, type).items;
  }

  @override
  Future<dynamic> getById(GeoType type, String id) async {}

  @override
  Future<City> getCityByCoordinates(double latitude, double longitude) async {}

  @override
  Future<List<Region>> getRegionsByCountry(String countryId, int offset) async {
    _pathUrl = '/v1/geo/countries/$countryId/regions';
    Map<String, String> queryParams = { 'offset': (fetchLimit*offset).toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    return GeoResponse.fromJson(response, GeoType.REGION).items;
  }

  @override
  Future<List<City>> getCitiesByRegion(String countryId, String regionId, int offset) async {
    _pathUrl = '/v1/geo/countries/$countryId/regions/$regionId/cities';
    Map<String, String> queryParams = { 'offset': (fetchLimit*offset).toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    return GeoResponse.fromJson(response, GeoType.CITY).items;
  }


}