import 'dart:async';

import 'package:trip_planner_app/api/api_response.dart';
import 'package:trip_planner_app/models/event/event.dart';
import 'package:trip_planner_app/models/event/freeEvent.dart';
import 'package:trip_planner_app/models/event/ticketedEvent.dart';
import 'package:trip_planner_app/services/free_events_service.dart';
import 'package:trip_planner_app/services/ticketed_events_service.dart';

class EventsBloc {
  FreeEventsService _freeEventsService;
  TicketedEventsService _ticketedEventsService;
  StreamController _eventsController;

  // Objecte que accepta events
  StreamSink<ApiResponse<List<Event>>> get eventsSink =>
      _eventsController.sink;

  Stream<ApiResponse<List<Event>>> get eventsStream =>
      _eventsController.stream;


  EventsBloc() {
    _eventsController = StreamController<ApiResponse<List<Event>>>();
    _freeEventsService = FreeEventsService();
    _ticketedEventsService = TicketedEventsService();
  }

  fetchFreeSightEvents(String latitude, String longitude, int numberOfEvents) async {
    eventsSink.add(ApiResponse.loading('Fetching Sight Events'));
    try {
      List<FreeEvent> freeSightEvent = await _freeEventsService.getFreeSightEvents(latitude, longitude, numberOfEvents);
      eventsSink.add(ApiResponse.completed(freeSightEvent));
    } catch (e) {
      eventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchFreeNightlifeEvents(String latitude, String longitude, int numberOfEvents) async {
    eventsSink.add(ApiResponse.loading('Fetching Nightlife Events'));
    try {
      List<FreeEvent> freeNightlifeEvent = await _freeEventsService.getFreeNightlifeEvents(latitude, longitude, numberOfEvents);
      eventsSink.add(ApiResponse.completed(freeNightlifeEvent));
    } catch (e) {
      eventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }
  fetchFreeRestaurantEvents(String latitude, String longitude, int numberOfEvents) async {
    eventsSink.add(ApiResponse.loading('Fetching Restaurant Events'));
    try {
      List<FreeEvent> freeRestaurantEvent = await _freeEventsService.getFreeRestaurantEvents(latitude, longitude, numberOfEvents);
      eventsSink.add(ApiResponse.completed(freeRestaurantEvent));
    } catch (e) {
      eventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchFreeShoppingEvents(String latitude, String longitude, int numberOfEvents) async {
    eventsSink.add(ApiResponse.loading('Fetching Shopping Events'));
    try {
      List<FreeEvent> freeShoppingEvent = await _freeEventsService.getFreeShoppingEvents(latitude, longitude, numberOfEvents);
      eventsSink.add(ApiResponse.completed(freeShoppingEvent));
    } catch (e) {
      eventsSink.add(ApiResponse.error(e.toString()));
      print(e);
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

  dispose() {
    _eventsController?.close();
  }
}