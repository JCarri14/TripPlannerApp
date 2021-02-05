import 'package:flutter/widgets.dart';

import '../models/tripPlan.dart';
import '../models/geo/city.dart';
import '../models/flight/flight.dart';
import '../models/flight/airport.dart';

class TripManager with ChangeNotifier {
    TripPlan _tripPlan;
    City _originCity;
    City _destinationCity;
    DateTime _destinationDay;
    DateTime _returnDay;
    int budget;
    String cityId;

    TripManager() {
      _tripPlan = new TripPlan();
      _originCity = new City();
      _destinationCity = new City();
    }

    void saveOriginCity(City city) {
      _originCity = city;
      notifyListeners();
    } 

    void saveDestinationCityId(String id) {
      this.cityId = id;
    }

    void saveDestinationCity(City city) {
      _destinationCity = city;
      notifyListeners();
    }

    void saveOriginAirport(Airport originAirport) {
      _tripPlan.originAirport = originAirport;
      notifyListeners();
    }

    void saveDestinationAirport(Airport destinationAirport) {
      _tripPlan.destinationAirport = destinationAirport;
      notifyListeners();
    }    

    void saveDepartureFlight(Flight df) {
      _tripPlan.departureFlight = df;
      notifyListeners();
    }

    void saveReturnFlight(Flight rf) {
      _tripPlan.returnFlight = rf;
      notifyListeners();
    }

    City get originCity {
      return _originCity;
    }

    String get positionId {
      return cityId;
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
      return _tripPlan.originAirport;
    }

    Airport get destinationAirport {
      return _tripPlan.destinationAirport;
    }

    Flight get departureFlight {
      return _tripPlan.departureFlight;
    }

    Flight get returnFlight {
      return _tripPlan.returnFlight;
    }

    void saveDestinationDay(DateTime destinationDay) {
      this._destinationDay = destinationDay;
      notifyListeners();
    }

    void saveReturnDay(DateTime returnDay) {
      this._returnDay = returnDay;
      notifyListeners();
    }

    void saveBudget(int budget) {
      this.budget = budget;
      notifyListeners();
    }

    
}