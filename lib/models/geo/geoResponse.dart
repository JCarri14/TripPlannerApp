import './city.dart';
import './country.dart';
import './region.dart';

enum GeoType { CITY, REGION, COUNTRY }

class GeoResponse {
  List<dynamic> items;
  int totalItems;
  String nextUrl;

  GeoResponse.fromJson(Map<String, dynamic> json, GeoType type) {
    if (json['data'] != null) {
      if (type == GeoType.CITY) items = new List<City>();
      if (type == GeoType.REGION) items = new List<Region>();
      if (type == GeoType.COUNTRY) items = new List<Country>();

      json['data'].forEach((c) {
        items.add(parseItem(type, c));
      });
    }
    
    if (json['links'] != null) {
      try {
        nextUrl = json['links'].firstWhere((l) => l['rel'] == 'next')['href'];
      } catch (e) {}
    }

    if (json['metadata'] != null) {
      totalItems = json['metadata']['totalCount'];
    }
  }

  dynamic parseItem(GeoType type, dynamic json) {
    switch(type) {
      case GeoType.CITY:
        return City.fromJson(json);
      case GeoType.COUNTRY:
        return Country.fromJson(json);
      case GeoType.REGION:
        return Region.fromJson(json);
      default:
        return City.fromJson(json);
    }
  }
}

