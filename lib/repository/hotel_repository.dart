import 'package:flutter/cupertino.dart';

abstract class HotelRepository {
  Future<String> getCityPositionId(BuildContext context, String cityName, String countryName);
  Future<List<dynamic>> getHotels(BuildContext context, String positionId, String checkIn, String checkOut, String priceMax);
}