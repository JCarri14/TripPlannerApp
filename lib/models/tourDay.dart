import 'package:trip_planner_app/models/event/event.dart';

class TourDay {
  final int MAX_LIMIT = 6;
  List<Event> dayEventsList;

  TourDay({this.dayEventsList});

  void addEvent(Event event){
    if(dayEventsList == null){
      dayEventsList = new List<Event>();
    }

    dayEventsList.add(event);
  }

  bool hasReachedLimit(){
    return dayEventsList.length >= MAX_LIMIT;

  factory TourDay.fromJsonResume(Map<String, dynamic> json){
    TourDay tourDay = new TourDay(dayEventsList: new List<Event>());

    for(Map<String, dynamic> event in json['dayEventsList']) {
      tourDay.dayEventsList.add(Event.fromJsonResume(event));
    }

    return tourDay;
  }

  String toJson(){
    String jsonResult = '{ "dayEventsList": [ ';
    for(Event event in dayEventsList){
      jsonResult += event.toJson() + ", ";
    }
    jsonResult += "] }";

    return jsonResult;
  }
}
