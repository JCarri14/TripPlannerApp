class Event {
  final String id;
  final String name;
  final String category;
  final int ranking;
  final double latitude;
  final double longitude;
  final String description;
  final String venue;
  final String startDatetime;
  final String endDatetime;
  final int price;

  Event({
    this.id = "", 
    this.name = "", 
    this.description = "",
    this.category = "", 
    this.ranking = 0, 
    this.latitude = 0.0, 
    this.longitude = 0.0,
    this.venue = "",
    this.startDatetime = "",
    this.endDatetime = "",
    this.price = -1
  });

  factory Event.fromJson(Map<String, dynamic> json){
    if(json['price'] == -1){
      return Event(id: json['id'],
        name: json['name'],
        ranking: json['ranking'],
        category: json['category'],
        latitude: json['latitude'],
        longitude: json['longitude']);
    } else {
      return Event(id: json['id'],
        name: json['title'],
        ranking: json['rank'] * 5 / 100,
        category: "${json['category'][0].toUpperCase()}${json['category'].substring(1)}",
        latitude: json['location'][0],
        longitude: json['location'][1],
        description: json['description'],
        venue: json['venue'],
        startDatetime: json['startDatetime'],
        endDatetime: json['endDatetime'],
        price: json['price']
      );
    }
  }

  String toJson() {
    return "{"
      '"id": ' + this.id + ","
      '"name": ' + this.name + ","
      '"category": ' + this.category + ","
      '"ranking": ' + this.ranking.toString() + ","
      '"latitude": ' + this.latitude.toString() + ","
      '"longitude": ' + this.longitude.toString() + ","
      '"description": ' + this.description + ","
      '"venue": ' + this.venue + ","
      '"startDatetime": ' + this.startDatetime + ","
      '"endDatetime": ' + this.endDatetime + ","
      '"price": ' + this.price.toString() + ","
      "}";
  }
}