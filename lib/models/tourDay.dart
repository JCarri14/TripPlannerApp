import 'package:trip_planner_app/models/event/event.dart';

class TourDay {
  List<Event> dayEventsList;

  TourDay({this.dayEventsList});

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
