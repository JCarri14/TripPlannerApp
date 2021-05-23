import '../models.dart';
import 'dart:math';

enum EventType { CITY_ID, FREE_EVENT, TICKETED_EVENT }

List<Event> normalizeEvents(EventType type, Map<String, dynamic> json) {
  List<Event> events = <Event>[];
  try {
    if(type == EventType.FREE_EVENT) {
      if (json['data'] != null) {
        print("PARSING FREE EVENTS");
        json['data'].forEach((c) {
          events.add(parseEvent(c));
        });
      }
    } else {
      print("PARSING TICKET EVENTS");
        if (json['results'] != null) {
          json['results'].forEach((c) {
            print("Parsing event");
            events.add(parsePaidEvent(c));
          });
        }
    }
  } catch(e) {
    print("ERROR:");
    print(e);
  }
    events.removeWhere((value) => value == null);
    print("LISTA:");
      print(events);
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
  return Event(
    id: json['id'] + json['title'],
    name: json['title'],
    //ranking: json['rank'] * 5 / 100,
    category: "${json['category'][0].toUpperCase()}${json['category'].substring(1)}",
    //latitude: double.parse(json['location'][0]),
    //longitude: double.parse(json['location'][1]),
    description: json['description'],
    venue: json['entities'].length > 0 ? json['entities'][0]['name']:"",
    startDatetime: json['start'],
    endDatetime: json['end'], 
  );
   
}

String parseEventCityID(Map<String, dynamic> json){
  return json['results'][0]['id'];
}