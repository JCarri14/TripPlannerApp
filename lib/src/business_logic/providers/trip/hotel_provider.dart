import 'dart:async';

import 'package:flutter/material.dart';

//SERVICE
import '../../../network/services.dart';
import '../../../network/api/api_response.dart';

//MODELS
import '../../models.dart';

class HotelProvider with ChangeNotifier {
  HotelService _hotelService;
  Set<Hotel> _hotels = new Set();
  Hotel _selectedHotel;
  String _cityPositionId;
  Status _fetchState;
  String _fetchError = "";

  HotelProvider() {
    _hotelService = HotelService();
  }

  List<Hotel> get hotels {
    return _hotels.toList();
  }

  Hotel get selectedHotel {
    return _selectedHotel;
  }

  String get cityPositionId {
    return _cityPositionId;
  }

  bool get isLoading {
    return _fetchState == Status.LOADING;
  }

  bool get isLoaded {
    return _fetchState == Status.COMPLETED;
  }

  bool get isError {
    return _fetchState == Status.ERROR;
  }

  String get fetchError {
    return _fetchError;
  }

  void saveSelectedHotel(Hotel h) {
    _selectedHotel = h;
    notifyListeners();
  }

  fetchCityPositionId(BuildContext context, String cityName, String countryName) async {
    _fetchState = Status.LOADING;
    try {
      _cityPositionId = await _hotelService.getCityPositionId(context, cityName, countryName);
      _fetchState = Status.COMPLETED;
    } catch (e) {
      _fetchError += e.toString();
      _fetchState = Status.ERROR;
    }
    notifyListeners();
  }

  fetchHotels(BuildContext context, String positionId, String checkIn, String checkOut, String priceMax) async {
    _fetchState = Status.LOADING;
    try {
      // Devuelve 25 hoteles
      List<Hotel> hotels = await _hotelService.getHotels(context, positionId, checkIn, checkOut, priceMax);
      _hotels.addAll(hotels);
      _fetchState = Status.COMPLETED;
    } catch (e) {
      _fetchError += e.toString();
      _fetchState = Status.ERROR;
    }
    notifyListeners();
  }
}