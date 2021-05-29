import '../models.dart';

enum HotelType { CITY_SEARCH, HOTEL_SEARCH }

List<Hotel> normalizeHotels(Map<String, dynamic> json){
  List<Hotel> hotels = <Hotel>[];
  json['data']['body']['searchResults']['results'].forEach((c) {
    hotels.add(Hotel.fromJson(c));
  });
  return hotels;
}

String normalizeHotelCityID(Map<String, dynamic> json){
  return json['suggestions'][0]['entities'][0]['destinationId'];
}