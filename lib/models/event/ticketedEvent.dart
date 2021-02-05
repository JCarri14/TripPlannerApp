import './event.dart';
import 'dart:math';

class TicketedEvent extends Event {
  String description;
  String venue;
  String startDatetime;
  String endDatetime;
  int price;

  TicketedEvent(json):super(id: json['id'],
      name: json['title'],
      ranking: json['rank'] * 5 / 100,
      category: "${json['category'][0].toUpperCase()}${json['category'].substring(1)}",
      latitude: json['location'][0],
      longitude: json['location'][1]);

  factory TicketedEvent.fromJson(Map<String, dynamic> json){
    TicketedEvent ticketedEvent = TicketedEvent(json);
    ticketedEvent.description = json['description'];
    ticketedEvent.venue = json['entities'][0]['name'];
    ticketedEvent.startDatetime = json['start'];
    ticketedEvent.endDatetime = json['end'];
    ticketedEvent.price = new Random().nextInt(40) + 5;
    return ticketedEvent;
  }
}