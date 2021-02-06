import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trip_planner_app/api/api_provider.dart';
import 'package:trip_planner_app/models/hotel/hotelCityIDResponse.dart';
import 'package:trip_planner_app/models/hotel/hotelResponse.dart';
import 'package:trip_planner_app/repository/hotel_repository.dart';

class HotelService implements HotelRepository {
  static const String _baseUrl = "hotels4.p.rapidapi.com";
  static const int fetchLimit = 5; // free-version constraint
  String _pathUrl;
  Map<String, String> _headers;
  ApiProvider _service = ApiProvider();

  HotelService() {
    _headers = {
      'x-rapidapi-key': env['API_KEY'],
      'x-rapidapi-host': env['API_HOST_HOTELS'],
      'useQueryString': 'true'
    };
  }

  Uri _createUri(Map<String, String> queryParams) {
    if (queryParams != null ) {
      return Uri.https(_baseUrl, _pathUrl, queryParams);
    }
    return Uri.https(_baseUrl, _pathUrl);
  }

  void _updatePath(HotelType type) {
    switch (type) {
      case HotelType.CITY_SEARCH:
        _pathUrl = "/locations/search/";
        break;
      case HotelType.HOTEL_SEARCH:
        _pathUrl = "/properties/list/";
        break;
    }
  }

  @override
  Future<String> getCityPositionId(BuildContext context, String cityName, String countryName) async {
    _updatePath(HotelType.CITY_SEARCH);
    Locale myLocale = Localizations.localeOf(context);
    String locale = myLocale.languageCode + "_" + myLocale.countryCode;
    Map<String, String> queryParams = { 'query': cityName + " " + countryName, 'locale': locale };
    final response = await _service.get(_createUri(queryParams), _headers);
    return HotelCityIDResponse.fromJson(response).id;
  }

  @override
  Future<List> getHotels(BuildContext context, String positionId, String checkIn, String checkOut, String priceMax) async {
    _updatePath(HotelType.HOTEL_SEARCH);

    Locale myLocale = Localizations.localeOf(context);
    String locale = myLocale.languageCode + "_" + myLocale.countryCode;
    
    Map<String, String> queryParams = { 
      "destinationId": positionId,
      'priceMax': priceMax,
      "pageNumber": "1",
      "checkIn": checkIn,
      "checkOut": checkOut,
      "pageSize": "25",
      "adults1": "1",
      'locale': locale,
      'currency': 'EUR',
      'sort': 'STAR_RATING_HIGHEST_FIRST'};
    final response = await _service.get(_createUri(queryParams), _headers);
    return HotelResponse.fromJson(response).items;
  }

}