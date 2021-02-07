import './event.dart';

enum FreeEventCategory {SIGHTS, NIGHTLIFE, RESTAURANT, SHOPPING}

class FreeEvent extends Event {

  FreeEvent(Map<String, dynamic> json): super(id: json['id'],
      name: json['name'],
      ranking: json['rank'],
      //category: "${json['category'][0]}${json['category'].substring(1).toLowerCase()}",
      
      latitude: json['geocode'] != null ? json['geocode']['latitude']: 0.0,
      longitude: json['geocode'] != null ? json['geocode']['longitude']: 0.0);

  factory FreeEvent.fromJson(Map<String, dynamic> json){
    print("Arriba a json");
    print(json);
    return FreeEvent(json);
  }

  static List<FreeEventCategory> getCategories(){
    return FreeEventCategory.values;
  }
}