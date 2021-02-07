import 'package:trip_planner_app/models/event/freeEvent.dart';
import 'package:trip_planner_app/models/event/ticketedEvent.dart';

import 'event.dart';

enum EventType { CITY_ID, FREE_EVENT, TICKETED_EVENT }

class EventResponse {
  List<dynamic> items;

  EventResponse.fromJson(EventType type, Map<String, dynamic> json){
    if(type == EventType.FREE_EVENT){
      if (items == null) items = new List<FreeEvent>();
      if (json['data'] != null) {
        json['data'].forEach((c) {
          items.add(FreeEvent.fromJson(c));
        });
        print("Despres for each!!, num elements: " + items.length.toString());
      }
    } else {
      if (items == null) items = new List<TicketedEvent>();
      if (json['results'] != null) {
        json['results'].forEach((c) {
          items.add(TicketedEvent.fromJson(c));
        });
      }
    }
  }
}