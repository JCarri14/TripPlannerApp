import 'package:trip_planner_app/models/event/freeEvent.dart';
import 'package:trip_planner_app/models/event/ticketedEvent.dart';

abstract class Event {
  String id;
  String name;
  String category;
  int ranking;
  double latitude;
  double longitude;

  Event({this.id, this.name, this.category, this.ranking, this.latitude, this.longitude});
  String toJson();

  factory Event.fromJsonResume(Map<String, dynamic> json){
    if(json['price'] == null){
      return FreeEvent.fromJsonResume(json);
    } else {
      return TicketedEvent.fromJsonResume(json);
    }
  }
}