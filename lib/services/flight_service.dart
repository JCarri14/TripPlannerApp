import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trip_planner_app/api/api_provider.dart';
import 'package:trip_planner_app/models/flight/flight.dart';
import 'package:trip_planner_app/models/flight/airport.dart';
import 'package:trip_planner_app/models/flight/flightResponse.dart';
import 'package:trip_planner_app/repository/flight_repository.dart';

class FlightService implements FlightRepository {
  static const String _baseUrl = "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com";
  static const int fetchLimit = 5; // free-version constraint
  String _pathUrl;
  Map<String, String> _headers;
  ApiProvider _service = ApiProvider();

  FlightService() {
    _headers = {
      'x-rapidapi-key': env['API_KEY'],
      'x-rapidapi-host': env['API_HOST_FLIGHT'],
      'useQueryString': 'true'
    };
  }

  Uri _createUri(Map<String, String> queryParams) {
    if (queryParams != null ) {
      return Uri.https(_baseUrl, _pathUrl, queryParams);
    }
    return Uri.https(_baseUrl, _pathUrl);
  }

  void _updatePath(BuildContext context, FlightType type, Map<String, String> pathParams) {
    Locale myLocale = Localizations.localeOf(context);
    String lang = myLocale.languageCode + "-" + myLocale.countryCode;
    switch (type) {
      case FlightType.AIRPORT:
        _pathUrl = "/apiservices/autosuggest/v1.0/" + myLocale.countryCode + "/EUR/" + lang + "/";
        break;
      case FlightType.ROUTE:
        _pathUrl = "/apiservices/browsedates/v1.0/" + myLocale.countryCode + "/EUR/" + lang + "/"
            + pathParams['origin'] + '/' + pathParams['destination'] + '/' + pathParams['arrivalDate'] + "/";
        break;
    }
  }

  @override
  Future<List<Airport>> getAirports(BuildContext context, String city, String country) async {
    _updatePath(context, FlightType.AIRPORT, null);
    Map<String, String> queryParams = { "query":  city + ", " + country};
    final response = await _service.get(_createUri(queryParams), _headers);
    return FlightResponse.fromJson(response, FlightType.AIRPORT).items;
  }

  @override
  Future<List<Flight>> getFlights(BuildContext context, String origin, String destination, String date) async {
    Map<String, String> pathParams = { 'origin':  origin, 'destination': destination, 'arrivalDate': date };
    _updatePath(context, FlightType.ROUTE, pathParams);
    final response = await _service.get(_createUri(null), _headers);
    return FlightResponse.fromJson(response, FlightType.ROUTE).items;
  }

}