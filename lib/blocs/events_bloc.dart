import 'dart:async';
import 'package:trip_planner_app/api/api_response.dart';
import 'package:trip_planner_app/models/event/event.dart';
import 'package:trip_planner_app/models/event/freeEvent.dart';
import 'package:trip_planner_app/models/event/ticketedEvent.dart';
import 'package:trip_planner_app/services/free_events_service.dart';
import 'package:trip_planner_app/services/ticketed_events_service.dart';
import './base_bloc.dart';
import '../models/event/event_type.dart';


class EventsBloc extends Bloc {
  FreeEventsService _freeEventsService;
  TicketedEventsService _ticketedEventsService;

  final Map<ContentType, List<Event>> eventsData = new Map();

  final _eventsController = StreamController<ApiResponse<List<Event>>>();
  
  StreamSink<ApiResponse<List<Event>>> get eventsSink =>
      _eventsController.sink;

  Stream<ApiResponse<List<Event>>> get eventsStream =>
      _eventsController.stream;

  EventsBloc() {
    _freeEventsService = FreeEventsService();
    _ticketedEventsService = TicketedEventsService();
  }

  void fetchFreeSightEvents(String latitude, String longitude, int numberOfEvents) async {
    if (eventsData[ContentType.SIGHT] != null && eventsData[ContentType.SIGHT].isEmpty) {
      eventsSink.add(ApiResponse.loading('Fetching Sight Events'));
      try {
        eventsData[ContentType.SIGHT] = await _freeEventsService.getFreeSightEvents(latitude, longitude, numberOfEvents);
        eventsSink.add(ApiResponse.completed(eventsData[ContentType.SIGHT]));
      } catch (e) {
        eventsSink.add(ApiResponse.error(e.toString()));
        print(e);
      }
    } else {
      eventsSink.add(ApiResponse.completed(eventsData[ContentType.SIGHT]));
    }
  }

  fetchFreeNightlifeEvents(String latitude, String longitude, int numberOfEvents) async {
    if (eventsData[ContentType.NIGHT_LIFE] != null && eventsData[ContentType.NIGHT_LIFE].isEmpty) {
      eventsSink.add(ApiResponse.loading('Fetching Nightlife Events'));
      try {
        eventsData[ContentType.NIGHT_LIFE] = await _freeEventsService.getFreeNightlifeEvents(latitude, longitude, numberOfEvents);
        eventsSink.add(ApiResponse.completed(eventsData[ContentType.NIGHT_LIFE]));
      } catch (e) {
        eventsSink.add(ApiResponse.error(e.toString()));
        print(e);
      }
    } else {
      eventsSink.add(ApiResponse.completed(eventsData[ContentType.NIGHT_LIFE]));
    }
  }
  
  fetchFreeRestaurantEvents(String latitude, String longitude, int numberOfEvents) async {
    //if (eventsData[ContentType.RESTAURANT] != null && eventsData[ContentType.RESTAURANT].isEmpty) {
      eventsSink.add(ApiResponse.loading('Fetching Restaurant Events'));
      try {
        eventsData[ContentType.RESTAURANT] = await _freeEventsService.getFreeRestaurantEvents(latitude, longitude, numberOfEvents);
        eventsSink.add(ApiResponse.completed(eventsData[ContentType.RESTAURANT]));
      } catch (e) {
        eventsSink.add(ApiResponse.error(e.toString()));
        print(e);
      }
    //} else {
    //  eventsSink.add(ApiResponse.completed(eventsData[ContentType.RESTAURANT]));
    //}
  }

  fetchFreeShoppingEvents(String latitude, String longitude, int numberOfEvents) async {
    if (eventsData[ContentType.SHOPPING] != null && eventsData[ContentType.SHOPPING].isEmpty) {
      eventsSink.add(ApiResponse.loading('Fetching Shopping Events'));
      try {
        eventsData[ContentType.SHOPPING] = await _freeEventsService.getFreeShoppingEvents(latitude, longitude, numberOfEvents);
        eventsSink.add(ApiResponse.completed(eventsData[ContentType.SHOPPING]));
      } catch (e) {
        eventsSink.add(ApiResponse.error(e.toString()));
        print(e);
      }
    } else {
      eventsSink.add(ApiResponse.completed(eventsData[ContentType.SHOPPING]));
    }
  }

  fetchTicketedExpoEvents(String day, String id, int numberOfEvents) async {
    eventsSink.add(ApiResponse.loading('Fetching Expo Events'));
    try {
      List<TicketedEvent> ticketedExpoEvent = await _ticketedEventsService.getTicketedExpoEvents(day, id, numberOfEvents);
      eventsSink.add(ApiResponse.completed(ticketedExpoEvent));
    } catch (e) {
      eventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchTicketedConcertEvents(String day, String id, int numberOfEvents) async {
    eventsSink.add(ApiResponse.loading('Fetching Concert Events'));
    try {
      List<TicketedEvent> ticketedConcertEvent = await _ticketedEventsService.getTicketedConcertEvents(day, id, numberOfEvents);
      eventsSink.add(ApiResponse.completed(ticketedConcertEvent));
    } catch (e) {
      eventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchTicketedFestivalEvents(String day, String id, int numberOfEvents) async {
    eventsSink.add(ApiResponse.loading('Fetching Festival Events'));
    try {
      List<TicketedEvent> ticketedFestivalEvent = await _ticketedEventsService.getTicketedFestivalEvents(day, id, numberOfEvents);
      eventsSink.add(ApiResponse.completed(ticketedFestivalEvent));
    } catch (e) {
      eventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchTicketedArtEvents(String day, String id, int numberOfEvents) async {
    eventsSink.add(ApiResponse.loading('Fetching Art Events'));
    try {
      List<TicketedEvent> ticketedArtEvent = await _ticketedEventsService.getTicketedArtEvents(day, id, numberOfEvents);
      eventsSink.add(ApiResponse.completed(ticketedArtEvent));
    } catch (e) {
      eventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchTicketedSportEvents(String day, String id, int numberOfEvents) async {
    eventsSink.add(ApiResponse.loading('Fetching Sport Events'));
    try {
      List<TicketedEvent> ticketedSportEvent = await _ticketedEventsService.getTicketedSportEvents(day, id, numberOfEvents);
      eventsSink.add(ApiResponse.completed(ticketedSportEvent));
    } catch (e) {
      eventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  @override
  void dispose() {
    _eventsController?.close();
  }
}