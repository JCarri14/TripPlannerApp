import 'package:flutter/widgets.dart';

import '../../models.dart';

class TripCreationProvider with ChangeNotifier {
  DateTime _destinationDay = DateTime.now();
  DateTime _returnDay = DateTime.now();
  City _originCity;
  City _destinationCity;
  Airport _originAirport;
  Airport _destinationAirport;
  Flight _departureFlight;
  Flight _returnFlight;
  Hotel _hotel;
  List<Event> _events;
  int _numAdults;
  int _numTeens;

  int _budget;
  String _cityId;

  TripCreationProvider():
    _originCity = new City(),
    _destinationCity = new City(),
    _originAirport = Airport(), 
    _destinationAirport = Airport(), 
    _departureFlight =  Flight(),
    _returnFlight = Flight(),
    _hotel = Hotel(),
    _events = [],
    _cityId = "",
    _numAdults = 0,
    _numTeens = 0,

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
    //this._totalDays = this._destinationDay.difference(returnDay).inDays;
    notifyListeners();
  }

  void saveBudget(int budget) {
    this._budget = budget;
    //notifyListeners();
  }

  void saveNumAdults(int numAdults) {
    this._numAdults = numAdults;
    notifyListeners();
  }

  void saveNumTeens(int numTeens) {
    this._numTeens = numTeens;
  }

  void saveOriginAirport(Airport originAirport) {
    _originAirport = originAirport;
    notifyListeners();
  }

  void saveDestinationAirport(Airport destinationAirport) {
    _destinationAirport = destinationAirport;
    notifyListeners();
  }    

  void saveDepartureFlight(Flight df) {
    _departureFlight = df;
    notifyListeners();
  }

  void saveReturnFlight(Flight rf) {
    _returnFlight = rf;
    notifyListeners();
  }

  void addTripEvent(Event event) {
    if (_events == null) _events = [];
    _events.add(event);
    notifyListeners();
  }

  void removeTripEvent(String id) {
    _events.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  bool isEventSelected(Event e) {
    return _events.contains(e);
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
    return _originAirport;
  }

  Airport get destinationAirport {
    return _destinationAirport;
  }

  Flight get departureFlight {
    return _departureFlight;
  }

  Flight get returnFlight {
    return _returnFlight;
  }

  int get budget {
    return _budget;
  }

  int get numAdults {
    return _numAdults;
  }

  int get numTeens {
    return _numTeens;
  }

  List<Event> get events {
    return _events;
  }

  Trip generateTrip() {
    Trip trip = new Trip();
    trip.destinationDay = _destinationDay;
    trip.returnDay = _returnDay;
    trip.originCity = _originCity;
    trip.destinationCity = _destinationCity;
    trip.originAirport = _originAirport;
    trip.destinationAirport = _destinationAirport;
    trip.departureFlight = _departureFlight;
    trip.returnFlight = _returnFlight;
    trip.hotel = _hotel;
    trip.events = _events;
    trip.numAdults = _numAdults;
    trip.numTeens = _numTeens;
    return trip;
  }

  void emptyFields() {
    _originCity = new City();
    _destinationCity = new City();
    _originAirport = Airport();
    _destinationAirport = Airport(); 
    _departureFlight =  Flight();
    _returnFlight = Flight();
    _hotel = Hotel();
    _events = [];
    _cityId = "";
    _budget = 0;
    _numAdults = 0;
    _numTeens = 0;
  }

}