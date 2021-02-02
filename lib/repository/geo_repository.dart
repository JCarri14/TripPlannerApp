import '../models/geo/city.dart';
import '../models/geo/region.dart';
import '../models/geo/geo.dart';

abstract class GeoRepository {
  Future<List<dynamic>> getAll(GeoType type, int offset);
  Future<List<dynamic>> getByPrefix(GeoType type, String prefix, int offset);
  Future<dynamic> getById(GeoType type, String id);
  Future<City> getCityByCoordinates(double latitude, double longitude);
  Future<List<Region>> getRegionsByCountry(String countryId, int offset);
  Future<List<City>> getCitiesByRegion(String countryId, String regionId, int offset);
}