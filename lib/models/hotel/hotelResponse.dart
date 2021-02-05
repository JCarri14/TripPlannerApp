import 'hotel.dart';

enum HotelType { CITY_SEARCH, HOTEL_SEARCH }

class HotelResponse {
  List<Hotel> items;

  HotelResponse.fromJson(Map<String, dynamic> json){
    items = new List<Hotel>();
    json['data']['body']['searchResults']['results'].forEach((c) {
      items.add(Hotel.fromJson(c));
    });
  }
}