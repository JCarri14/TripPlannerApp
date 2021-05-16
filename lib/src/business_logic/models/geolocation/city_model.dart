class City {
  final String apiId;
  final String name;
  final String region;
  final String country;
  final double latitude;
  final double longitude;

  City({
    this.apiId = "", 
    this.name = "", 
    this.region = "", 
    this.country = "", 
    this.latitude = 0.0, 
    this.longitude = 0.0
  });

  String toString() {
    if(name == ""){
      return "";
    }
    return this.name + ", " + this.country + ", " + this.region;
  }

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      apiId: json['apiId'],
      name: json['name'],
      region: json['region'],
      country: json['country'],
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  }
}

class CityThumbnail {
  final String smallFormatURI;
  final String largeFormatURI;

  CityThumbnail({
    this.smallFormatURI = "", 
    this.largeFormatURI = ""
    });

  factory CityThumbnail.fromJson(Map<String, dynamic> json) {
    return CityThumbnail(
      smallFormatURI: json['smallFormatURI'],
      largeFormatURI: json['largeFormatURI'],
    );
  }
}
