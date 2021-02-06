import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trip_planner_app/api/api_provider.dart';
import 'package:trip_planner_app/models/event/eventResponse.dart';
import 'package:trip_planner_app/models/event/freeEvent.dart';
import 'package:trip_planner_app/repository/free_events_repository.dart';
import 'package:trip_planner_app/utils/utils.dart';

class FreeEventsService implements FreeEventsRepository {
  static const String _baseUrl = "hotels4.p.rapidapi.com";
  static const int fetchLimit = 5; // free-version constraint
  String _pathUrl = "/reference-data/locations/pois";
  Map<String, String> _headers;
  ApiProvider _service = ApiProvider();

  HotelService() {
    _headers = {
      'Authorization': "Bearer " + env['API_ACCESS_TOKEN_FREE_EVENTS'],
      'useQueryString': 'true'
    };
  }

  Uri _createUri(Map<String, String> queryParams) {
    if (queryParams != null ) {
      return Uri.https(_baseUrl, _pathUrl, queryParams);
    }
    return Uri.https(_baseUrl, _pathUrl);
  }

  @override
  Future<List<dynamic>> getFreeSightEvents(String latitude, String longitude, int numberOfEvents) async {
    Map<String, String> queryParams = {'latitude': latitude, 'longitude': longitude, 'categories': getEnumName(FreeEventCategory.SIGHTS), 'radius': "15", "page[limit]": numberOfEvents.toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    return EventResponse.fromJson(EventType.FREE_EVENT, response).items;
  }

  @override
  Future<List<dynamic>> getFreeNightlifeEvents(String latitude, String longitude, int numberOfEvents) async {
    Map<String, String> queryParams = {'latitude': latitude, 'longitude': longitude, 'categories': getEnumName(FreeEventCategory.NIGHTLIFE), 'radius': "15", "page[limit]": numberOfEvents.toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    return EventResponse.fromJson(EventType.FREE_EVENT, response).items;
  }

  @override
  Future<List<dynamic>> getFreeRestaurantEvents(String latitude, String longitude, int numberOfEvents) async {
    Map<String, String> queryParams = {'latitude': latitude, 'longitude': longitude, 'categories': getEnumName(FreeEventCategory.RESTAURANT), 'radius': "15", "page[limit]": numberOfEvents.toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    return EventResponse.fromJson(EventType.FREE_EVENT, response).items;
  }

  @override
  Future<List<dynamic>> getFreeShoppingEvents(String latitude, String longitude, int numberOfEvents) async {
    Map<String, String> queryParams = {'latitude': latitude, 'longitude': longitude, 'categories': getEnumName(FreeEventCategory.SHOPPING), 'radius': "15", "page[limit]": numberOfEvents.toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    return EventResponse.fromJson(EventType.FREE_EVENT, response).items;
  }

}