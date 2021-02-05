import 'dart:async';

import 'package:trip_planner_app/api/api_response.dart';
import 'package:trip_planner_app/models/event/freeEvent.dart';
import 'package:trip_planner_app/services/free_events_service.dart';

class FreeEventsBloc {
  FreeEventsService _freeEventsService;
  StreamController _freeEventsController;

  // Objecte que accepta events
  StreamSink<ApiResponse<List<FreeEvent>>> get freeEventsSink =>
      _freeEventsController.sink;

  Stream<ApiResponse<List<FreeEvent>>> get freeEventsStream =>
      _freeEventsController.stream;


  FreeEventsBloc() {
    _freeEventsController = StreamController<ApiResponse<List<FreeEvent>>>();
    _freeEventsService = FreeEventsService();
  }

  fetchFreeSightEvents(String latitude, String longitude, int numberOfEvents) async {
    freeEventsSink.add(ApiResponse.loading('Fetching Sight Events'));
    try {
      List<FreeEvent> freeSightEvent = await _freeEventsService.getFreeSightEvents(latitude, longitude, numberOfEvents);
      freeEventsSink.add(ApiResponse.completed(freeSightEvent));
    } catch (e) {
      freeEventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }
  fetchFreeNightlifeEvents(String latitude, String longitude, int numberOfEvents) async {
    freeEventsSink.add(ApiResponse.loading('Fetching Nightlife Events'));
    try {
      List<FreeEvent> freeNightlifeEvent = await _freeEventsService.getFreeNightlifeEvents(latitude, longitude, numberOfEvents);
      freeEventsSink.add(ApiResponse.completed(freeNightlifeEvent));
    } catch (e) {
      freeEventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }
  fetchFreeRestaurantEvents(String latitude, String longitude, int numberOfEvents) async {
    freeEventsSink.add(ApiResponse.loading('Fetching Restaurant Events'));
    try {
      List<FreeEvent> freeRestaurantEvent = await _freeEventsService.getFreeRestaurantEvents(latitude, longitude, numberOfEvents);
      freeEventsSink.add(ApiResponse.completed(freeRestaurantEvent));
    } catch (e) {
      freeEventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }
  fetchFreeShoppingEvents(String latitude, String longitude, int numberOfEvents) async {
    freeEventsSink.add(ApiResponse.loading('Fetching Shopping Events'));
    try {
      List<FreeEvent> freeShoppingEvent = await _freeEventsService.getFreeShoppingEvents(latitude, longitude, numberOfEvents);
      freeEventsSink.add(ApiResponse.completed(freeShoppingEvent));
    } catch (e) {
      freeEventsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _freeEventsController?.close();
  }
}