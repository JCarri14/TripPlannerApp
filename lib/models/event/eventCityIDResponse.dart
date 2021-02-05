class EventCityIDResponse {
  String id;

  EventCityIDResponse.fromJson(Map<String, dynamic> json){
    id =  json['results'][0]['id'];
  }
}