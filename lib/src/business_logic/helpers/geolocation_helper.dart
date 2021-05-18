import '../models.dart';

enum GeoType { CITY, REGION, COUNTRY }

List<City> normalizeCities(Map<String, dynamic> json) {
  List<City> cities = <City>[];
  if (json['data'] != null) {
    json['data'].forEach((c) {
      cities.add(parseCity(c));
    });
  }
  return cities;
}

City parseCity(Map<String, dynamic> json) {
  return City(
      apiId: json['wikiDataId'],
      name: json['name'],
      region: json['region'],
      country: json['country'],
      latitude: json['latitude'],
      longitude: json['longitude']
    );
}

List<CityThumbnail> normalizeCityThumbnails(Map<String, dynamic> json) {
  List<CityThumbnail> cityThumbnails = <CityThumbnail>[];
  if (json['data'] != null) {
    json['data'].forEach((c) {
      cityThumbnails.add(parseCityThumbnail(c));
    });
  }
  return cityThumbnails;
}

CityThumbnail parseCityThumbnail(Map<String, dynamic> json) {
  return CityThumbnail(
    smallFormatURI: json['photos']['mobile'],
    largeFormatURI: json['photos']['web'],
  );
}

List<Country> normalizeCountries(Map<String, dynamic> json) {
  List<Country> countries = <Country>[];
  if (json['data'] != null) {
    json['data'].forEach((c) {
      countries.add(parseCountry(c));
    });
  }
  return countries;
}

Country parseCountry(Map<String, dynamic> json) {
  return Country(
    apiId: json['wikiDataId'],
    name: json['name'],
    code: json['code']
  );
}

List<Region> normalizeRegions(Map<String, dynamic> json) {
  List<Region> regions = <Region>[];
  if (json['data'] != null) {
    json['data'].forEach((r) {
      regions.add(parseRegion(r));
    });
  }
  return regions;
}

Region parseRegion(Map<String, dynamic> json) {
  return Region(
    apiId: json['wikiDataId'],
    name: json['name'],
    code: json['isoCode'],
    countryCode: json['countryCode']
  );
}