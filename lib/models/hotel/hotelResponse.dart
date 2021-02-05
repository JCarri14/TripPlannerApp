import 'hotel.dart';

enum HotelType { CITY_SEARCH, HOTEL_SEARCH }

class HotelResponse {
  List<Hotel> items;

  HotelResponse.fromJson(Map<String, dynamic> json){
    json['data']['body']['searchResults']['results'].forEach((c) {
      items.add(Hotel.fromJson(json));
    });
  }
}