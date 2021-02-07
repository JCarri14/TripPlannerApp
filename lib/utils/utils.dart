import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_planner_app/models/userData.dart';
import 'dart:convert';

String getEnumName(Object enumEntry){
  describeEnum(enumEntry);
}

Future<UserData> getHistoryTrips() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String historyTrips = prefs.getString('history_trips');

  return UserData.fromJsonResume(json.decode(historyTrips));
}

Future<void> setHistoryTrips(UserData userData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('history_trips', userData.toJson());
}