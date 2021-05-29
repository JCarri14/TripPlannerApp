import '../models.dart';
import 'dart:math';

enum EventType { CITY_ID, FREE_EVENT, TICKETED_EVENT }

List<Event> normalizeEvents(EventType type, Map<String, dynamic> json) {
  List<Event> events = <Event>[];
  try {
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
  } catch(e) {
    print("ERROR:");
    print(e);
  }
  events.removeWhere((value) => value == null);
  return events;
}

Event parseEvent(Map<String, dynamic> json) {
  return Event(
    id: json['id'],
    name: json['name'],
    ranking: double.parse(json['rating']),
    description: json['shortDescription'],
    category: json['type'],
    thumbnail: json['pictures'].length > 0 ? json['pictures'][0]:"",
    latitude: json['geocode'] != null ? double.parse(json['geocode']['latitude']): 0.0,
    longitude: json['geocode'] != null ? double.parse(json['geocode']['longitude']): 0.0,
    price: json['price'] != null ? double.parse(json['price']['amount']):0, 
  );
}

Event parsePaidEvent(Map<String, dynamic> json) {
  int rank = json['rank'];
  return Event(
    id: json['id'] + json['title'],
    name: json['title'],
    ranking: double.parse(rank.toString()),
    category: "${json['category'][0].toUpperCase()}${json['category'].substring(1)}",
    latitude: (json['location'][0]),
    longitude: (json['location'][1]),
    description: json['description'],
    venue: json['entities'].length > 0 ? json['entities'][0]['name']:"",
    startDatetime: json['start'],
    endDatetime: json['end'], 
  );
   
}

String parseEventCityID(Map<String, dynamic> json){
  return json['results'][0]['id'];
}