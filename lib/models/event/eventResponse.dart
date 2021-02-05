import 'package:trip_planner_app/models/event/freeEvent.dart';
import 'package:trip_planner_app/models/event/ticketedEvent.dart';

import 'event.dart';

enum EventType { CITY_ID, FREE_EVENT, TICKETED_EVENT }

class EventResponse {
  List<Event> items;

  EventResponse.fromJson(EventType type, Map<String, dynamic> json){
    if(type == EventType.FREE_EVENT){
      json['data'].forEach((c) {
        items.add(FreeEvent.fromJson(c));
      });
    } else {
      json['results'].forEach((c) {
        items.add(TicketedEvent.fromJson(c));
      });
    }
  }
}