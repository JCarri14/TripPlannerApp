import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';
import '../api/api_provider.dart';

// REPOSITORY
import "../repositories/free_events_repository.dart";

// MODELS
import "../../business_logic/models.dart";

// HELPER
import "../../business_logic/helpers.dart";

// UTILS
import "../../utils/utils.dart";



class FreeEventsService implements FreeEventsRepository {
  static const String _baseUrl = "test.api.amadeus.com";
  static const _interestsUrl = "/v1/reference-data/locations/pois";
  static const _activitiesUrl = "/v1/shopping/activities";
  static const String _tokenUrl = "https://test.api.amadeus.com/v1/security/oauth2/token";
  static const int fetchLimit = 5; // free-version constraint
  Map<String, String> _headers;
  String sessionToken;
  ApiProvider _service = ApiProvider();

  FreeEventsService() {
    _headers = {
      'Authorization': sessionToken,
    };
    _requestToken();
  }

  Uri _createUri(Map<String, String> queryParams) {
    if (queryParams != null ) {
      return Uri.https(_baseUrl, _activitiesUrl, queryParams);
    }
    return Uri.https(_baseUrl, _activitiesUrl);
  }

  void _requestToken() async {
    Map<String, String> tokenBody = {
      "grant_type": "client_credentials",
      "client_id": env['API_KEY_FREE_EVENTS'],
      "client_secret": env['API_KEY_SECRET_FREE_EVENTS'],
    };
    await _service.post(_tokenUrl, tokenBody).then((res) {
      sessionToken = res['token_type'] + " " + res['access_token'];
      _headers = {
        'Authorization': sessionToken,
      };
      print("Free Events Token");
      print(sessionToken);
    });
  }

  @override
  Future<List<dynamic>> getFreeSightEvents(String latitude, String longitude, int numberOfEvents) async {
    Map<String, String> queryParams = {'latitude': latitude, 'longitude': longitude, 'categories': getEnumName(FreeEventCategory.SIGHTS), 'radius': "15", "page[limit]": numberOfEvents.toString() };
    var response;
    try {
      response = await _service.get(_createUri(queryParams), _headers);
    } catch(e) {
      if (e.toString().contains("Access token expired")) {
        await _requestToken();
        response = await _service.get(_createUri(queryParams), _headers);
      }
    }
    return normalizeEvents(EventType.FREE_EVENT, response);
  }

  @override
  Future<List<dynamic>> getFreeNightlifeEvents(String latitude, String longitude, int numberOfEvents) async {
    Map<String, String> queryParams = {'latitude': latitude, 'longitude': longitude, 'categories': getEnumName(FreeEventCategory.NIGHTLIFE), 'radius': "15", "page[limit]": numberOfEvents.toString() };
    var response;
    try {
      response = await _service.get(_createUri(queryParams), _headers);
    } catch(e) {
      if (e.toString().contains("Access token expired")) {
        await _requestToken();
        response = await _service.get(_createUri(queryParams), _headers);
      }
    }
    return normalizeEvents(EventType.FREE_EVENT, response);
  }

  @override
  Future<List<dynamic>> getFreeRestaurantEvents(String latitude, String longitude, int numberOfEvents) async {
    print(sessionToken);
    //Map<String, String> queryParams = {'latitude': latitude, 'longitude': longitude, 'categories': getEnumName(FreeEventCategory.RESTAURANT), 'radius': "15", "page[limit]": numberOfEvents.toString() };
    Map<String, String> queryParams = {'latitude': latitude, 'longitude': longitude};
    var response;
    try {
      response = await _service.get(_createUri(queryParams), _headers);
    } catch(e) {
      if (e.toString().contains("Access token expired")) {
        await _requestToken();
        response = await _service.get(_createUri(queryParams), _headers);
      }
    }
    return normalizeEvents(EventType.FREE_EVENT, response);
  }

  @override
  Future<List<dynamic>> getFreeShoppingEvents(String latitude, String longitude, int numberOfEvents) async {
    Map<String, String> queryParams = {'latitude': latitude, 'longitude': longitude, 'categories': getEnumName(FreeEventCategory.SHOPPING), 'radius': "15", "page[limit]": numberOfEvents.toString() };
    var response;
    try {
      response = await _service.get(_createUri(queryParams), _headers);
    } catch(e) {
      if (e.toString().contains("Access token expired")) {
        await _requestToken();
        response = await _service.get(_createUri(queryParams), _headers);
      }
    }
    return normalizeEvents(EventType.FREE_EVENT, response);
  }

}