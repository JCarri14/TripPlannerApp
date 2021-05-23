import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'geo_service.dart';

import '../api/api_provider.dart';

// REPOSITORY
import "../repositories/ticketed_events_repository.dart";

// MODELS
import "../../business_logic/models.dart";

// HELPER
import "../../business_logic/helpers.dart";

class TicketedEventsService implements TicketedEventsRepository {
  static const String _baseUrl = "api.predicthq.com";
  static const int fetchLimit = 5; // free-version constraint
  String _pathUrl = "/v1/events";
  Map<String, String> _headers;
  ApiProvider _service = ApiProvider();

  TicketedEventsService() {
    _headers = {
      'Authorization': "Bearer " + env['API_ACCESS_TOKEN_TICKETED_EVENTS'],
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
        _pathUrl = "/v1/places";
        break;
      default:
        _pathUrl = "/v1/events";
        break;
    }
  }

  @override
  Future<String> getPlaceId(double longitude, double latitude) async {
    _updatePath(EventType.CITY_ID);
    Map<String, String> queryParams = {'location': "@" + GeoService.generateLocationString(latitude, longitude), 'type': 'locality', 'limit': "1" };
    final response = await _service.get(_createUri(queryParams), _headers);
    print("RESPONSE");
    print(response);
    return parseEventCityID(response);
  }

  @override
  Future<List<Event>> getTicketedExpoEvents(String day, String location, int numberOfEvents) async {
    _updatePath(EventType.TICKETED_EVENT);
    Map<String, String> queryParams = { 
      'category': 'expos', 
      'location_around.origin': location, 
      'location_around.offset:': '50km',
      'start.gte': day, 
      'start.lte': day, 
      'limit': numberOfEvents.toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    return normalizeEvents(EventType.TICKETED_EVENT, response);
  }

  @override
  Future<List<Event>> getTicketedConcertEvents(String day, String location, int numberOfEvents) async {
    _updatePath(EventType.TICKETED_EVENT);
    Map<String, String> queryParams = { 
      'category': 'concerts', 
      'location_around.origin': location, 
      'location_around.offset:': '50km',
      'start.gte': day, 
      'start.lte': day, 
      'limit': numberOfEvents.toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    print("RESPONSE");
    print(response);
    return normalizeEvents(EventType.TICKETED_EVENT, response);
  }

  @override
  Future<List<Event>> getTicketedFestivalEvents(String day, String location, int numberOfEvents) async {
    _updatePath(EventType.TICKETED_EVENT);
    Map<String, String> queryParams = { 
      'category': 'festivals', 
      'location_around.origin': location, 
      'location_around.offset:': '50km',
      'start.gte': day, 
      'start.lte': day, 
      'limit': numberOfEvents.toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    print("RESPONSE");
    print(response);
    return normalizeEvents(EventType.TICKETED_EVENT, response);
  }

  @override
  Future<List<Event>> getTicketedArtEvents(String day, String location, int numberOfEvents) async {
    _updatePath(EventType.TICKETED_EVENT);
    Map<String, String> queryParams = { 
      'category': 'performing-arts', 
      'location_around.origin': location, 
      'location_around.offset:': '50km',
      'start.gte': day, 
      'start.lte': day, 
      'limit': numberOfEvents.toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    print("RESPONSE");
    print(response);
    return normalizeEvents(EventType.TICKETED_EVENT, response);
  }

  @override
  Future<List<Event>> getTicketedSportEvents(String day, String location, int numberOfEvents) async {
    _updatePath(EventType.TICKETED_EVENT);
    Map<String, String> queryParams = { 
      'category': 'sports', 
      'location_around.origin': location, 
      'location_around.offset:': '50km',
      'start.gte': day, 
      'start.lte': day, 
      'limit': numberOfEvents.toString() };
    final response = await _service.get(_createUri(queryParams), _headers);
    print("RESPONSE");
    print(response);
    return normalizeEvents(EventType.TICKETED_EVENT, response);
  }

}