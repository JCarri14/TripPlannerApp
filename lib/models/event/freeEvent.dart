import './event.dart';

enum FreeEventCategory {SIGHTS, NIGHTLIFE, RESTAURANT, SHOPPING}

class FreeEvent extends Event {
  FreeEvent(json): super(id: json['id'],
      name: json['name'],
      ranking: json['rank'],
      category: "${json['category'][0]}${json['category'].substring(1).toLowerCase()}",
      latitude: json['geocode']['latitude'],
      longitude: json['geocode']['longitude']);

  factory FreeEvent.fromJson(Map<String, dynamic> json){
    return FreeEvent(json);
  }

  static List<FreeEventCategory> getCategories(){
    return FreeEventCategory.values;
  }
}