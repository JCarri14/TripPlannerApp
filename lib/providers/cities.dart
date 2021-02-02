import 'package:flutter/material.dart';
import '../models/geo/city.dart';

class Cities with ChangeNotifier {
  List<City> _cities = [];

  List<City> get cities {
    return [..._cities];
  }

  void search(String cityInput) {
    
    /*var uri = Uri.https(
        'www.myurl.com', '/api/v1/test/${widget.pk}', queryParameters);
    var response = await http.get(uri, headers: {
      "x-rapidapi-key": "8660dc3c28mshcc34c866e5fd1ccp1cebbejsn080da52b433b"
    });*/

    notifyListeners();

  }
}
