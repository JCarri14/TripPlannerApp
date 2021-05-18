import '../models.dart';
import 'dart:math';

enum EventType { CITY_ID, FREE_EVENT, TICKETED_EVENT }

List<Event> normalizeEvents(EventType type, Map<String, dynamic> json) {
  List<Event> events = <Event>[];

  if(type == EventType.FREE_EVENT) {
    if (json['data'] != null) {
      json['data'].forEach((c) {
        events.add(parseEvent(c));
      });
    }
  } else {
      if (json['results'] != null) {
        json['results'].forEach((c) {
          events.add(parsePaidEvent(c));
        });
      }
  }
  return events;
}

Event parseEvent(Map<String, dynamic> json) {
  return Event(
    id: json['id'],
    name: json['name'],
    ranking: json['rank'],
    category: "${json['category'][0]}${json['category'].substring(1).toLowerCase()}",
    latitude: json['geocode'] != null ? json['geocode']['latitude']: 0.0,
    longitude: json['geocode'] != null ? json['geocode']['longitude']: 0.0
  );
}

Event parsePaidEvent(Map<String, dynamic> json) {
  return Event(id: json['id'],
    name: json['title'],
    ranking: json['rank'] * 5 / 100,
    category: "${json['category'][0].toUpperCase()}${json['category'].substring(1)}",
    latitude: json['location'][0],
    longitude: json['location'][1],
    description: json['description'],
    venue: json['entities'][0]['name'],
    startDatetime: json['start'],
    endDatetime: json['end'],
    price: new Random().nextInt(40) + 5
   );
}

String parseEventCityID(Map<String, dynamic> json){
  return json['results'][0]['id'];
}