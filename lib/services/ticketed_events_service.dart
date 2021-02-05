import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trip_planner_app/api/api_provider.dart';
import 'package:trip_planner_app/models/event/eventCityIDResponse.dart';
import 'package:trip_planner_app/models/event/eventResponse.dart';
import 'package:trip_planner_app/models/event/ticketedEvent.dart';
import 'package:trip_planner_app/repository/ticketed_events_repository.dart';

import 'geo_service.dart';

class TicketedEventsService implements TicketedEventsRepository {
  static const String _baseUrl = "api.predicthq.com/v1";
  static const int fetchLimit = 5; // free-version constraint
  String _pathUrl = "/events";
  Map<String, String> _headers;
  ApiProvider _service = ApiProvider();

  HotelService() {
    _headers = {
      'Authorization': "Bearer " + env['API_ACCESS_TOKEN_TICKETED_EVENTS'],
      'useQueryString': 'true'
    };
  }

  Uri _createUri(Map<String, String> queryParams) {
    if (queryParams != null ) {
      return Uri.https(_baseUrl, _pathUrl, queryParams);
    }
    return Uri.https(_baseUrl, _pathUrl);
  }

  void _updatePath(EventType type) {
    switch (type) {
      case EventType.CITY_ID:
        _pathUrl = "/places";
        break;
      default:
        _pathUrl = "/events";
        break;
    }
  }

  @override
  Future<String> getPlaceId(double longitude, double latitude) async {
    _updatePath(EventType.CITY_ID);
    Map<String, String> queryParams = {'location': "@" + GeoService.generateLocationString(latitude, longitude), 'type': 'locality', 'limit': "1" };
    final response = await _service.get(_createUri(queryParams), _headers);
    return EventCityIDResponse.fromJson(response).id;
  }

  @override
  Future<List<TicketedEvent>> getTicketedExpoEvents(String day, String id, int numberOfEvents) async {
    _updatePath(EventType.TICKETED_EVENT);
    Map<String, String> queryParams = { 'category': 'expos', 'place.exact': id, 'start.gte': day, 'start.lte': day, 'limit': numberOfEvents.toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    return EventResponse.fromJson(EventType.TICKETED_EVENT, response).items;
  }

  @override
  Future<List<TicketedEvent>> getTicketedConcertEvents(String day, String id, int numberOfEvents) async {
    _updatePath(EventType.TICKETED_EVENT);
    Map<String, String> queryParams = { 'category': 'concerts', 'place.exact': id, 'start.gte': day, 'start.lte': day, 'limit': numberOfEvents.toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    return EventResponse.fromJson(EventType.TICKETED_EVENT, response).items;
  }

  @override
  Future<List<TicketedEvent>> getTicketedFestivalEvents(String day, String id, int numberOfEvents) async {
    _updatePath(EventType.TICKETED_EVENT);
    Map<String, String> queryParams = { 'category': 'festivals', 'place.exact': id, 'start.gte': day, 'start.lte': day, 'limit': numberOfEvents.toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    return EventResponse.fromJson(EventType.TICKETED_EVENT, response).items;
  }

  @override
  Future<List<TicketedEvent>> getTicketedArtEvents(String day, String id, int numberOfEvents) async {
    _updatePath(EventType.TICKETED_EVENT);
    Map<String, String> queryParams = { 'category': 'performing-arts', 'place.exact': id, 'start.gte': day, 'start.lte': day, 'limit': numberOfEvents.toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    return EventResponse.fromJson(EventType.TICKETED_EVENT, response).items;
  }

  @override
  Future<List<TicketedEvent>> getTicketedSportEvents(String day, String id, int numberOfEvents) async {
    _updatePath(EventType.TICKETED_EVENT);
    Map<String, String> queryParams = { 'category': 'sports', 'place.exact': id, 'start.gte': day, 'start.lte': day, 'limit': numberOfEvents.toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    return EventResponse.fromJson(EventType.TICKETED_EVENT, response).items;
  }

}