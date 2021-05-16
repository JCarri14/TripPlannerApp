import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// MODELS
import '../../business_logic/models.dart';

// HELPERS
import "../../business_logic/helpers.dart";

// NETWORK
import '../api/api_provider.dart';
import '../repositories/flight_repository.dart';

enum FlightType {AIRPORT, ROUTE}

class FlightService implements FlightRepository {
  static const String _baseUrl = "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com";
  static const int fetchLimit = 5; // free-version constraint
  String _pathUrl = "";
  Map<String, String> _headers = {};
  
  ApiProvider _service = ApiProvider();

  FlightService() {
    _headers['x-rapidapi-key'] = (env['API_KEY'] != null ? env['API_KEY']: "")! ;
    _headers['x-rapidapi-host'] = (env['API_HOST_FLIGHT'] != null ? env['API_HOST_FLIGHT']: "")!;
    _headers['useQueryString'] = 'true';
  }

  Uri _createUri(Map<String, String> queryParams) {
    if (queryParams.isNotEmpty) {
      return Uri.https(_baseUrl, _pathUrl, queryParams);
    }
    return Uri.https(_baseUrl, _pathUrl);
  }

  void _updatePath(BuildContext context, FlightType type, Map<String, String> pathParams) {
    Locale myLocale = Localizations.localeOf(context);
    String lang = myLocale.languageCode + "-" + (myLocale.countryCode)!;
    switch (type) {
      case FlightType.AIRPORT:
        _pathUrl = "/apiservices/autosuggest/v1.0/" + (myLocale.countryCode)! + "/EUR/" + lang + "/";
        break;
      case FlightType.ROUTE:
        _pathUrl = "/apiservices/browsedates/v1.0/" + (myLocale.countryCode)! + "/EUR/" + lang + "/"
            + (pathParams['origin'])! + '/' + (pathParams['destination'])! + '/' + (pathParams['arrivalDate'])! + "/";
        break;
    }
  }

  @override
  Future<List<Airport>> getAirports(BuildContext context, String city, String country) async {
    _updatePath(context, FlightType.AIRPORT, {});
    Map<String, String> queryParams = { "query":  city };
    final response = await _service.get(_createUri(queryParams), _headers);
    return FlightHelper.normalizeAirports(response);
  }

  @override
  Future<List<Flight>> getFlights(BuildContext context, String origin, String destination, String date) async {
    Map<String, String> pathParams = { 'origin':  origin, 'destination': destination, 'arrivalDate': date };
    _updatePath(context, FlightType.ROUTE, pathParams);
    final response = await _service.get(_createUri({}), _headers);
    return FlightHelper.normalizeFlights(response);
  }

}