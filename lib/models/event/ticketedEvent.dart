import './event.dart';
import 'dart:math';

enum TicketedEventCategory {CONFERENCES, EXPOS, CONCERTS, FESTIVALS, ARTS, SPORTS}

class TicketedEvent extends Event {
  String description;
  String venue;
  String startDatetime;
  String endDatetime;
  int price;

  TicketedEvent({id, name, ranking, category, latitude, longitude}): super(id: id, name: name, ranking: ranking, category: category, latitude: latitude, longitude: longitude);

  factory TicketedEvent.fromJson(Map<String, dynamic> json){
    TicketedEvent ticketedEvent = TicketedEvent(id: json['id'],
        name: json['title'],
        ranking: json['rank'] * 5 / 100,
        category: "${json['category'][0].toUpperCase()}${json['category'].substring(1)}",
        latitude: json['location'][0],
        longitude: json['location'][1]);
    ticketedEvent.description = json['description'];
    ticketedEvent.venue = json['entities'][0]['name'];
    ticketedEvent.startDatetime = json['start'];
    ticketedEvent.endDatetime = json['end'];
    ticketedEvent.price = new Random().nextInt(40) + 5;
    return ticketedEvent;
  }

  factory TicketedEvent.fromJsonResume(Map<String, dynamic> json){
    TicketedEvent ticketedEvent = TicketedEvent(id: json['id'],
        name: json['title'],
        ranking: json['rank'] * 5 / 100,
        category: "${json['category'][0].toUpperCase()}${json['category'].substring(1)}",
        latitude: json['location'][0],
        longitude: json['location'][1]);
    ticketedEvent.description = json['description'];
    ticketedEvent.venue = json['venue'];
    ticketedEvent.startDatetime = json['startDatetime'];
    ticketedEvent.endDatetime = json['endDatetime'];
    ticketedEvent.price = json['price'];
    return ticketedEvent;
  }

  static List<TicketedEventCategory> getCategories(){
    return TicketedEventCategory.values;
  }

  @override
  String toJson() {
    return "{"
        '"id": ' + this.id + ","
        '"name": ' + this.name + ","
        '"category": ' + this.category + ","
        '"ranking": ' + this.ranking.toString() + ","
        '"latitude": ' + this.latitude.toString() + ","
        '"longitude": ' + this.longitude.toString() + ","
        '"description": ' + this.description + ","
        '"venue": ' + this.venue + ","
        '"startDatetime": ' + this.startDatetime + ","
        '"endDatetime": ' + this.endDatetime + ","
        '"price": ' + this.price.toString() + ","
        "}";
  }
}