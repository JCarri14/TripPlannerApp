import 'package:trip_planner_app/models/tripPlan.dart';

class UserData {
  final List<TripPlan> tripPlanHistory;

  UserData({this.tripPlanHistory});

  factory UserData.fromJsonResume(Map<String, dynamic> json){
    UserData userData = new UserData(tripPlanHistory : new List<TripPlan>());

    for(Map<String, dynamic> value in json['tripPlanHistory']){
      userData.tripPlanHistory.add(TripPlan.fromJsonResume(value));
    }

    return userData;
  }

  String toJson(){
    String jsonResult = "{ tripPlanHistory: [";
    for(TripPlan trip in tripPlanHistory){
      jsonResult += trip.toJson() + ", ";
    }
    jsonResult += "] }";

    return jsonResult;
  }
}