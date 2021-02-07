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
  }
}
