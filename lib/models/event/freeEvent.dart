import './event.dart';

enum FreeEventCategory {SIGHTS, NIGHTLIFE, RESTAURANT, SHOPPING}

class FreeEvent extends Event {
  FreeEvent({id, name, ranking, category, latitude, longitude}): super(id: id, name: name, ranking: ranking, category: category, latitude: latitude, longitude: longitude);

  factory FreeEvent.fromJson(Map<String, dynamic> json){
    return FreeEvent(id: json['id'],
        name: json['name'],
        ranking: json['rank'],
        category: "${json['category'][0]}${json['category'].substring(1).toLowerCase()}",
        latitude: json['geocode'] != null ? json['geocode']['latitude']: 0.0,
        longitude: json['geocode'] != null ? json['geocode']['longitude']: 0.0);
  }

  factory FreeEvent.fromJsonResume(Map<String, dynamic> json){
    return FreeEvent(id: json['id'],
        name: json['name'],
        ranking: json['ranking'],
        category: json['category'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }

  static List<FreeEventCategory> getCategories(){
    return FreeEventCategory.values;
  }

  @override
  String toJson() {
    return "{"
        '"id": ' + this.id + ","
        '"name": ' + this.name + ","
        '"category": ' + this.category + ","
        '"ranking": ' + this.ranking.toString() + ","
        '"latitude": ' + this.latitude.toString() + ","
        '"longitude": ' + this.longitude.toString() + ","
        "}";
  }
}
