class HotelCityIDResponse {
  String id;

  HotelCityIDResponse.fromJson(Map<String, dynamic> json){
    id =  json['suggestions'][0]['entities'][0]['destinationId'];
  }
}