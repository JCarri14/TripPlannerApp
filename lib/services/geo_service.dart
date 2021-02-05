import 'dart:core';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../api/api_provider.dart';
import '../repository/geo_repository.dart';

import '../models/geo/city.dart';
import '../models/geo/region.dart';
import '../models/geo/geoResponse.dart';

import 'package:geolocator/geolocator.dart';

class GeoService implements GeoRepository {
  static const String _baseUrl = "wft-geo-db.p.rapidapi.com";
  static const int fetchLimit = 5; // free-version constraint
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
      case GeoType.REGION:
        break;
    }
  }

  static String generateLocationString(double latitude, double longitude){
    String latitudeName, longitudeName;

    if(latitude < 0){
      latitudeName = latitude.toStringAsFixed(4);
    } else {
      latitudeName = "+" + latitude.toStringAsFixed(4);
    }

    if(longitude < 0){
      longitudeName = longitude.toStringAsFixed(4);
    } else {
      longitudeName = "+" + longitude.toStringAsFixed(4);
    }

    return latitudeName + longitudeName;
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<List<dynamic>> getAll(GeoType type, int offset) async {
    _updatePath(type);
    Map<String, String> queryParams = { 'limit': offset.toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    return GeoResponse.fromJson(response, type).items;
  }

  @override
  Future<List<dynamic>> getByPrefix(GeoType type, String prefix, int offset) async {
    _updatePath(type);
    Map<String, String> queryParams = {'namePrefix': prefix, 'limit': offset.toString(), 'sort': 'name'};
    final response = await _service.get(_createUri(queryParams), _headers);
    return GeoResponse.fromJson(response, type).items;
  }

  Future<List<dynamic>> getByProximity(GeoType type, int offset) async {
    _updatePath(type);
    Position myPosition = await _determinePosition();
    Map<String, String> queryParams = {'location': generateLocationString(myPosition.latitude, myPosition.longitude), 'radius': "1000", 'limit': offset.toString()};
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