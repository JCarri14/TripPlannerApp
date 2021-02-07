class Airport {
  final String airportId;
  final String cityId;
  final String placeName;
  final String countryName;
  
  Airport({this.airportId,
  this.cityId,
  this.placeName,
  this.countryName});

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      airportId: json['PlaceId'],
      cityId: json['CityId'],
      placeName: json['PlaceName'],
      countryName: json['CountryName']
    );
  }

  factory Airport.fromJsonResume(Map<String, dynamic> json) {
    return Airport(
        airportId: json['airportId'],
        cityId: json['cityId'],
        placeName: json['placeName'],
        countryName: json['countryName']
    );
  }

  String toJson(){
    return "{"
        '"airportId": ' + this.airportId + ","
        '"cityId": ' + this.cityId + ","
        '"placeName": ' + this.placeName + ","
        '"countryName": ' + this.countryName + ","
        "}";
  }
}
