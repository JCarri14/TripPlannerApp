import 'package:flutter/widgets.dart';

import '../../models.dart';

class TripCreationProvider with ChangeNotifier {
  Trip _trip;
  City _originCity;
  City _destinationCity;
  DateTime _destinationDay = DateTime.now();
  DateTime _returnDay = DateTime.now();
  int _budget;
  String _stringBudget;
  String _cityId;
  int _totalDays;

  TripCreationProvider():
    _trip = new Trip(),
    _originCity = new City(),
    _destinationCity = new City(),
    _cityId = "",
    _totalDays = 0,
    _stringBudget = "",
    _budget = 0;


  void saveOriginCity(City city) {
    _originCity = city;
    notifyListeners();
  } 

  void saveDestinationCityId(String id) {
    this._cityId = id;
  }

  void saveDestinationCity(City city) {
    _destinationCity = city;
    notifyListeners();
  }

  void saveDestinationDay(DateTime destinationDay) {
    this._destinationDay = destinationDay;
    notifyListeners();
  }

  void saveReturnDay(DateTime returnDay) {
    this._returnDay = returnDay;
    this._totalDays = this._destinationDay.difference(returnDay).inDays;
    notifyListeners();
  }

  void saveBudget(int budget) {
    this._budget = budget;
    notifyListeners();
  }

  void saveOriginAirport(Airport originAirport) {
    _trip.originAirport = originAirport;
    notifyListeners();
  }

  void saveDestinationAirport(Airport destinationAirport) {
    _trip.destinationAirport = destinationAirport;
    notifyListeners();
  }    

  void saveDepartureFlight(Flight df) {
    _trip.departureFlight = df;
    notifyListeners();
  }

  void saveReturnFlight(Flight rf) {
    _trip.returnFlight = rf;
    notifyListeners();
  }

  void addTripEvent(Event event) {
    _trip.addEvent(event);
    print("Trip added");
    notifyListeners();
  }

  void removeTripEvent(String id) {
    _trip.removeEvent(id);
    notifyListeners();
  }

  bool isEventSelected(Event e) {
    print("List size: " + _trip.events.length.toString());
    bool res = _trip.events.contains(e);
    print("Is selected? " + (res ? "Yes":"No"));
    return res;
  }

  City get originCity {
    return _originCity;
  }

  String get positionId {
    return _cityId;
  }

  City get destinationCity {
    return _destinationCity;
  }

  String get destinationDate {
    return _destinationDay.toString().split(" ")[0];
  }

  String get returnDate {
    return _returnDay.toString().split(" ")[0];
  }

  Airport get originAirport {
    return _trip.originAirport;
  }

  Airport get destinationAirport {
    return _trip.destinationAirport;
  }

  Flight get departureFlight {
    return _trip.departureFlight;
  }

  Flight get returnFlight {
    return _trip.returnFlight;
  }

  String get stringBudget {
    return _stringBudget;
  }

  int get budget {
    return _budget;
  }

}