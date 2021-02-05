class City {
  String apiId;
  String name;
  String region;
  String country;
  double latitude;
  double longitude;

  City({this.apiId, this.name = "", this.region = "", this.country = "", this.latitude, this.longitude});

  String toString() {
    if(name == ""){
      return "";
    }
    return this.name + ", " + this.country + ", " + this.region;
  }

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      apiId: json['wikiDataId'],
      name: json['name'],
      region: json['region'],
      country: json['country'],
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  }
}
