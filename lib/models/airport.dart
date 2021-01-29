class Airport {
  final String id;
  final String city;
  final String country;
  final String countryId;
  final String regionId;
  final String cityId;
  
  Airport({this.id, 
  this.city, 
  this.country,
  this.countryId, 
  this.regionId,
  this.cityId});

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      id: json['PlaceId'],
      city: json['PlaceName'],
      country: json['CountryName'],
      countryId: json['CountryId'],
      regionId: json['RegionId'],
      cityId: json['CityId'],
    );
  }
}
