import 'package:flutter/widgets.dart';

// MODELS
import '../models.dart';

class AppProvider with ChangeNotifier {

  List<Trip> _trips;

  AppProvider():
    _trips = [];
  

  List<Trip> get trips {
    return _trips;
  }

  void addTrip(Trip t) {
    _trips.add(t);
    notifyListeners();
  }

   void removeTrip(Trip t) {
    _trips.remove(t);
    notifyListeners();
  }

}