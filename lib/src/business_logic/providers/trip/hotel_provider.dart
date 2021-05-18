import 'dart:async';

import 'package:flutter/material.dart';

//SERVICE
import '../../../network/services.dart';
import '../../../network/api/api_response.dart';

//MODELS
import '../../models.dart';

class HotelProvider {
  HotelService _hotelService;
  StreamController _positionIDController;
  StreamController _hotelListController;

  // Objecte que accepta events
  StreamSink<ApiResponse<String>> get positionIDSink =>
      _positionIDController.sink;

  Stream<ApiResponse<String>> get positionIDStream =>
      _positionIDController.stream;

  // Objecte que accepta events
  StreamSink<ApiResponse<List<Hotel>>> get hotelListSink =>
      _hotelListController.sink;

  Stream<ApiResponse<List<Hotel>>> get hotelListStream =>
      _hotelListController.stream;

  HotelProvider() {
    _positionIDController = StreamController<ApiResponse<String>>();
    _hotelListController = StreamController<ApiResponse<List<Hotel>>>();
    _hotelService = HotelService();
  }

  fetchCityPositionId(BuildContext context, String cityName, String countryName) async {
    positionIDSink.add(ApiResponse.loading('Fetching Position ID'));
    try {
      String positionID = await _hotelService.getCityPositionId(context, cityName, countryName);
      positionIDSink.add(ApiResponse.completed(positionID));
    } catch (e) {
      positionIDSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchHotels(BuildContext context, String positionId, String checkIn, String checkOut, String priceMax) async {
    hotelListSink.add(ApiResponse.loading('Fetching Hotels'));
    try {
      // Devuelve 25 hoteles
      List<Hotel> hotels = await _hotelService.getHotels(context, positionId, checkIn, checkOut, priceMax);
      hotelListSink.add(ApiResponse.completed(hotels));
    } catch (e) {
      hotelListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _positionIDController?.close();
    _hotelListController?.close();
  }
}