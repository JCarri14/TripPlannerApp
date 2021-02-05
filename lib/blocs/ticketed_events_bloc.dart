import 'dart:async';

import 'package:trip_planner_app/api/api_response.dart';
import 'package:trip_planner_app/models/event/ticketedEvent.dart';
import 'package:trip_planner_app/services/ticketed_events_service.dart';

class TicketedEventsBloc {
  TicketedEventsService _ticketedEventsService;
  StreamController _ticketedEventsController;
  StreamController _positionIDController;

  // Objecte que accepta events
  StreamSink<ApiResponse<String>> get positionIDSink =>
      _positionIDController.sink;

  Stream<ApiResponse<String>> get positionIDStream =>
      _positionIDController.stream;

  StreamSink<ApiResponse<List<TicketedEvent>>> get ticketedEventsSink =>
      _ticketedEventsController.sink;

  Stream<ApiResponse<List<TicketedEvent>>> get ticketedEventsStream =>
      _ticketedEventsController.stream;

  TicketedEventsBloc() {
    _positionIDController = StreamController<ApiResponse<String>>();
    _ticketedEventsController = StreamController<ApiResponse<List<TicketedEvent>>>();
    _ticketedEventsService = TicketedEventsService();
  }

  fetchCityPositionId(double longitude, double latitude) async {
    positionIDSink.add(ApiResponse.loading('Fetching Position ID'));
    try {
      String positionID = await _ticketedEventsService.getPlaceId(longitude, latitude);
      positionIDSink.add(ApiResponse.completed(positionID));
    } catch (e) {
      positionIDSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchTicketedExpoEvents(String day, String id, int numberOfEvents) async {
    ticketedEventsSink.add(ApiResponse.loading('Fetching Expo Events'));
    try {
      List<TicketedEvent> ticketedExpoEvent = await _ticketedEventsService.getTicketedExpoEvents(day, id, numberOfEvents);
      ticketedEventsSink.add(ApiResponse.completed(ticketedExpoEvent));
    } catch (e) {
      ticketedEventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchTicketedConcertEvents(String day, String id, int numberOfEvents) async {
    ticketedEventsSink.add(ApiResponse.loading('Fetching Concert Events'));
    try {
      List<TicketedEvent> ticketedConcertEvent = await _ticketedEventsService.getTicketedConcertEvents(day, id, numberOfEvents);
      ticketedEventsSink.add(ApiResponse.completed(ticketedConcertEvent));
    } catch (e) {
      ticketedEventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchTicketedFestivalEvents(String day, String id, int numberOfEvents) async {
    ticketedEventsSink.add(ApiResponse.loading('Fetching Festival Events'));
    try {
      List<TicketedEvent> ticketedFestivalEvent = await _ticketedEventsService.getTicketedFestivalEvents(day, id, numberOfEvents);
      ticketedEventsSink.add(ApiResponse.completed(ticketedFestivalEvent));
    } catch (e) {
      ticketedEventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchTicketedArtEvents(String day, String id, int numberOfEvents) async {
    ticketedEventsSink.add(ApiResponse.loading('Fetching Art Events'));
    try {
      List<TicketedEvent> ticketedArtEvent = await _ticketedEventsService.getTicketedArtEvents(day, id, numberOfEvents);
      ticketedEventsSink.add(ApiResponse.completed(ticketedArtEvent));
    } catch (e) {
      ticketedEventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchTicketedSportEvents(String day, String id, int numberOfEvents) async {
    ticketedEventsSink.add(ApiResponse.loading('Fetching Sport Events'));
    try {
      List<TicketedEvent> ticketedSportEvent = await _ticketedEventsService.getTicketedSportEvents(day, id, numberOfEvents);
      ticketedEventsSink.add(ApiResponse.completed(ticketedSportEvent));
    } catch (e) {
      ticketedEventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _positionIDController?.close();
    _ticketedEventsController?.close();
  }
}